#!/usr/bin/perl -- -*- Mode: cperl; coding: unicode-utf8; -*-
package heavy_template::layout;
use base 'Class::Singleton';
use Apache::HeavyCGI::Layout;
use heavy_template::main;
use strict;
use vars qw( $Exeplan );

sub layout {
  my($self) = shift;
  my speed_link::lexikon::main $mgr = shift;
  my @l;
  push @l, qq{<TABLE BORDER><TR><TD>};
  push @l, "LAY";
  push @l, qq{</TD><TD>};
  push @l, "out";
  push @l, qq{</TD></TR><TR><TD>};
  push @l, $mgr->instance_of("heavy_template::usermenu");
  push @l, qq{</TD><TD>};
  push @l, "Hello world,";
  push @l, qq{</TD></TR></TABLE>};
  Apache::HeavyCGI::Layout->new(@l);
}

1;
