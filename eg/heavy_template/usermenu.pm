#!/usr/bin/perl -- -*- Mode: cperl; coding: unicode-utf8; -*-
package heavy_template::usermenu;
use base 'Class::Singleton';
use heavy_template::main;
use strict;
use vars qw( $Exeplan );

sub parameter {
  my heavy_template::usermenu $self = shift;
  my heavy_template::main $mgr = shift;
  return;
}

sub as_string {
  my heavy_template::usermenu $self = shift;
  my heavy_template::main $mgr = shift;
  my $user = $mgr->{R}->connection->user;
  "Hello $user,";
}

1;
