package heavy_template::fake_authen_user;
use Apache ();
use strict;
use Apache::Constants qw(OK AUTH_REQUIRED DECLINED);

sub handler {
    my($r) = @_;
    return OK unless $r->is_initial_req; #only the first internal request
    my($res, $sent_pw) = $r->get_basic_auth_pw;
    return $res if $res; #decline if not Basic
    my $user = $r->connection->user;
    return DECLINED unless length($user);
    return OK;
}

1;
