package admctrl;  # should be CIVS, or perhaps CIVS::Common
use strict;
use warnings;

use Socket;

our $home = "@CIVSDATADIR@";
our $admission_socket = $home.'/elections/admission_control';
our $cr = "\r\n";

sub Busy {
    print 'Server: Apache/2.0.40 (Red Hat Linux)', $cr,
	  'Accept-Ranges: bytes', $cr,
	  'Content-Length: 357', $cr,
	  'Connection: close', $cr,
	  'Content-Type: text/html; charset=ISO-8859-1', $cr, $cr,
	  '<html>', $cr,
	  '<head>', $cr,
	  '<meta http-equiv="Content-Type" content="text/html">', $cr,
	  '<title>Condorcet Internet Voting Service</title>', $cr,
          '<link rel="stylesheet" type="text/css" href="/~andru/civs/style.css" />',$cr,
          '</head>',$cr,
          '<body>',$cr,
          '<h1>CIVS Server busy</h1>',$cr,
          '<p>The server is currently too busy to service your',$cr,
          'request. Please try again in a few minutes.</p>',$cr,
          '</body>',$cr,
          '</html>',$cr;
}

sub AdmissionControl {
    # if ($local_debug) { return 1; }
    my $maxthreads = 8;
    if (!socket(ADMCTRL, &AF_UNIX, &SOCK_STREAM, 0)) {
	print "Can't open socket: $!\n";
	exit 1;
    }
    my $sa = pack_sockaddr_un($admission_socket);
    if (!connect ADMCTRL, $sa) {
	unlink($admission_socket);
	system("killall lockserv");
	# print "<pre>$home/pgrp $home/lockserv $admission_socket $maxthreads</pre>";
	system("$home/pgrp $home/lockserv $admission_socket $maxthreads");
	sleep(1);
	if (!connect(ADMCTRL, $sa)) {
	    print "Can't start it!?\n";
	    exit 1;
	}
	chmod 0777, $admission_socket;
    }
    my $success = <ADMCTRL>;
    #HTML_Header("Debugging admission control");
    #print pre($success);
    if ($success eq '') {
	&Busy;
	exit 0;
    } else {
	return 1; # gained admission
    }
}

&AdmissionControl;
