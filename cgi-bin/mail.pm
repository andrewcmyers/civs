package mail;   # should be CIVS::Mail

# TODO: This package should be rewritten to be a wrapper around 
# Mail::Mailer or Net::SMTP.

use strict;
use warnings;
use MIME::Base64;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&Send &ConsumeSMTP &ConnectMail &CloseMail
		      &CheckAddr &TrimAddr &SendHeader);
}

# Package imports
use civs_common;
use Socket;

# Non-exported package globals
our $sin;
our $verbose;

&init;

# Initialize package
sub init {
	# connect(SMTP, $sin) || print "Can't connect\n";

	$verbose = 0;
}

sub Init_mail_socket {
    my $proto = getprotobyname('tcp');
    socket(SMTP, &PF_INET, &SOCK_STREAM, $proto) ||
	print "can't open socket: $!\n";
    my $port = getservbyname('smtp', 'tcp') ||
	print "can't get port\n";
    if ($port eq '') { exit 1; }
    my $iaddr = gethostbyname('@SMTPHOST@') ||
	print "no such host\n";
    if ($iaddr eq '') { exit 1; }
    $sin = pack_sockaddr_in($port, $iaddr);
}

# Package functions

sub CheckAddr {
    (my $addr) = @_;
    chomp $addr;

    return ($addr =~ m/^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|edu|com|org|net|gov|mil|biz|int|cat|asia|coop|info|mobi|name|pro|tel|travel|aero|jobs|museum|xxx)$/i);
}

sub TrimAddr {
    (my $addr) = @_;
    $addr =~ s/^(\s)+//;
    $addr =~ s/(\s)+$//;
    $addr =~ s/\s+/ /;
    return $addr;
}

sub Send {
    foreach my $s (@_) {
	if ($verbose || $local_debug) {
	    print $s."\n"; STDOUT->flush();
	}
	if (!($local_debug)) {
	    print SMTP $s."\r\n";
	}
    }
}

# Read a response from the SMTP server after making sure it has all
# pending input. Return zero iff an error code is reported.
sub SendSMTP {
    if ($local_debug) { return 1; }
    SMTP->flush;
    while (<SMTP>) {
	if ($verbose) {
	    print $_; STDOUT->flush();
	}
	if ($_ =~ m/^[123][0-9][0-9] /) { last; }
	if ($_ =~ m/^[45][0-9][0-9] /) { print "SMTP server rejects request: $_"; return 0; }
    }
    return 1;
}

# Like SendSMTP, but terminates if there is an error.
sub ConsumeSMTP {
    if (!SendSMTP) {
	exit 1;
    }
}

# Set up a connection to the SMTP server so email can be sent
sub ConnectMail {
    if ($local_debug) {
	print "<pre>\r\n";
	return;
    }
    &Init_mail_socket;
    if (connect(SMTP, $sin)) {
        #print STDERR "SMTP Connection established\n";
	ConsumeSMTP;
	Send 'helo @THISHOST@';
	ConsumeSMTP;
    } else {
	die "Can't connect to SMTP server: $!\n";
    }
}

# Close the connection to the SMTP server.
sub CloseMail {
    Send 'quit';
    if ($local_debug) {
	print '</pre>';
    } else {
	close SMTP;
    }
}

sub SendHeader {
    my $header = shift @_;
    my $first = 1;
    my $text = '';
    foreach my $section (@_) {
	# print CGI::pre('Section: ', $section);
	if (!$first) { $text .= "\r\n " }
	$first = 0;
	if ($section =~ m/[\200-\377]/) {
	    my $budget = 75 - 12 - length($header) - 2;
	    $budget -= $budget % 4;
	    my $enc = MIME::Base64::encode_base64($section,'');
	    my $i = 0;
	    while ($i < length($enc)) {
		if ($i != 0) {
		    $text .= "\r\n ";
		}
		$text .= '=?utf-8?B?' . substr($enc, $i, $budget) . '?=';
		$i += $budget;
		$budget = 60;
	    }
	} else {
	    $text .= $section;
	}
    }
    Send $header . ': ' . $text;
    # print CGI::pre($header. ': '. $text);
}
 
1; #ok
