#!/usr/bin/perl -- -*- Mode: cperl; coding: unicode-utf8; -*-
package heavy_template::config;
use heavy_template::main;
use Apache::HeavyCGI::ExePlan;
use Apache::Request;
use strict;
use vars qw( $Exeplan );

# Tell the system which packages need to see the headers or the
# parameters.
$Exeplan = Apache::HeavyCGI::ExePlan->new(
					  CLASSES => [qw(
heavy_template::usermenu
)]);

sub handler {
  my($r) = shift;
  my heavy_template::main $self = heavy_template::main
      ->new(

	    EXECUTION_PLAN => $Exeplan,
	    R       => $r,
	    RootURL => "/pause", # just an example
	    # add more instance variables here. Make sure, they are
	    # declared in main.pm

	   );
  $self->{CGI} = Apache::Request->new($r);
  $self->dispatch;
}

1;
