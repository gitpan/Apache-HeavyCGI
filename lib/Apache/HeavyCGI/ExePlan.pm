package Apache::HeavyCGI::ExePlan;
use Apache::HeavyCGI; # want only the instance_of method
use strict;
use fields qw(PLAN DEBUG FUNCTIONAL);

use vars '%FIELDS', '$VERSION';
$VERSION = sprintf "%d.%03d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/;

# no singleton, every Application can have its own execution plan even
# every object can have it's own, although, it probably doesn't pay

sub new {
  my($me,%arg) = @_;
  my $methods = $arg{METHODS} || [qw(header parameter)];
  my $classes = $arg{CLASSES} || [];
  my $functional = $arg{FUNCTIONAL} || 0; #### undocumented
  my $debug   = $arg{DEBUG} || 0; #### undocumented
  my @plan;
  for my $method (@$methods) {
    for my $class (@$classes) {
      my($obj,$subr);
      eval { $obj = $class->instance; };
      if ($@) {
	$obj = Apache::HeavyCGI->instance_of($class);
      }
      next unless $subr = $obj->can($method);
      if ($functional) {
	push @plan, $subr, $obj;
      } else {
	push @plan, $obj, $method;
      }
    }
  }
  no strict "refs";
  my $self = bless [\%{"$me\::FIELDS"}], $me;
  $self->{PLAN} = [ @plan ];
  $self->{FUNCTIONAL} = $functional;
  $self->{DEBUG} = $debug;
  $self;
}

sub walk {
  my Apache::HeavyCGI::ExePlan $self = shift;
  my Apache::HeavyCGI $application = shift;
  for (my $i=0;;$i+=2) {
    warn sprintf "entering i[$i]" if $self->{DEBUG} && $self->{DEBUG} & 1;
    if ($self->{FUNCTIONAL}) {
      my $subr = $self->{PLAN}[$i] or last;
      my $obj = $self->{PLAN}[$i+1];
      $subr->($obj,$application);
    } else {
      my $obj = $self->{PLAN}[$i] or last;
      my $method = $self->{PLAN}[$i+1];
      $obj->$method($application);
    }
    warn sprintf "exiting i[$i]" if $self->{DEBUG} && $self->{DEBUG} & 2;
  }
}

1;

__END__


=head1 NAME

Apache::HeavyCGI::ExePlan - Creates an execution plan for Apache::HeavyCGI

=head1 SYNOPSIS

 use Apache::HeavyCGI::ExePlan;
 my $plan = Apache::HeavyCGI::ExePlan->new(
    METHODS => ["header", "parameter"],
    CLASSES => ["my_application::foo", "my_application::bar", ... ]
    DEBUG    => 1
 );

 $plan->walk;

=head1 DESCRIPTION

When an execution plan object is instantiated, it immediately visits
all specified classes, collects the singleton objects for these
classes, and checks if the classes define the specified methods. It
creates an array of objects and methods or an array of code
references.

The walk method walks through the execution plan in the stored order
and sends each singleton object the appropriate method and passes the
application object as the first argument.

Normally, every application has its own execution plan. If the
execution plan is calculated at load time of the application class,
all objects of this class can share a common execution plan, thus
speeding up the requests. Consequently it is recommended to have an
initialization in all applications that instantiates an execution plan
and passes it to all application objects in the constructor.

head1 BUGS

It's not a bug, it's a feature: if new methods and classes are
dynamically created in an application, the execution plan object won't
take note.


=cut

