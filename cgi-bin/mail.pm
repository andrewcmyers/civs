package mail;   # should be CIVS::Mail

# TODO: This package should be rewritten to be a wrapper around 
# Mail::Mailer or Net::SMTP.

use strict;
use warnings;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&Send &ConsumeSMTP &ConnectMail &CloseMail);
}

# Package imports
use civs_common;
use Socket;

# Non-exported package globals
our $sin;
our $verbose;

# Package initialization code

&init;

sub init {
	if (!($local_debug)) {
		my $proto = getprotobyname('tcp');
		socket(SMTP, &PF_INET, &SOCK_STREAM, $proto) || print "can't open socket: $!\n";
		my $port = getservbyname('smtp', 'tcp') || print "can't get port\n";
		if ($port eq '') { exit 1; }
		my $iaddr = gethostbyname('@SMTPHOST@') || print "no such host\n";
		if ($iaddr eq '') { exit 1; }
		$sin = pack_sockaddr_in($port, $iaddr);
	}

	# connect(SMTP, $sin) || print "Can't connect\n";

	$verbose = 0;
}

# Package functions

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
        #print STDERR "SMTP Connection established\n";
	ConsumeSMTP;
	Send 'helo @THISHOST@';
	ConsumeSMTP;
    } else {
		die "Can't connect to SMTP server: $!\n";
    }
}

sub CloseMail {
	Send 'quit';
	close SMTP;
}

1; #ok
