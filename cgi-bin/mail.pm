use Socket;
use IO::Handle;

$proto = getprotobyname('tcp');
socket(SMTP, PF_INET, SOCK_STREAM, $proto) || print "can't open socket\n";
$port = getservbyname('smtp', 'tcp') || print "can't get port\n";
if ($port eq '') { exit 1; }
$iaddr = gethostbyname('smtp.cs.cornell.edu') || print "no such host\n";
if ($iaddr eq '') { exit 1; }
$sin = pack_sockaddr_in($port, $iaddr);

# connect(SMTP, $sin) || print "Can't connect\n";

$verbose = 0;

sub Send {
    if ($verbose) {
	print $_[0]."\n"; STDOUT->flush();
    }
    print SMTP $_[0]."\r\n";
}

sub ConsumeSMTP {
    SMTP->flush;
    while (<SMTP>) {
	if ($verbose) {
	    print $_; STDOUT->flush();
	}
	if ($_ =~ m/^[123][0-9][0-9] /) { last; }
	if ($_ =~ m/^[45][0-9][0-9] /) { print "SMTP server rejects request: $_"; exit 1; }
    }
}

sub ConnectMail {
    if (connect(SMTP, $sin)) {
	print STDERR "SMTP Connection established\n";
	ConsumeSMTP;
	Send "helo www5.cs.cornell.edu";
	ConsumeSMTP;
    } else {
	print STDERR "Can't connect\n";
	exit 1;
    }
}

1; #ok
