package heavy_template::main;
use base Apache::HeavyCGI;
use fields qw(
RootURL
);

sub layout {
  my speed_link::lexikon::main $self = shift;
  $self->instance_of("heavy_template::layout")->layout($self);
}

1;

