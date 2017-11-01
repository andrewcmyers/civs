package mail;   # should be CIVS::Mail

# TODO: This package should be rewritten to be a wrapper around 
# Mail::Mailer or Net::SMTP.

use strict;
use warnings;
use MIME::Base64;
use Authen::SASL;
use Net::SMTP;
use IO::Socket::SSL;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&OpenMail &CloseMail &MailFrom &MailTo
                      &StartMailData &EndMailData &Send &SendHeader
                      &CheckAddr &TrimAddr);
}

# Package imports
use civs_common;
use Socket;

# Non-exported package globals
our $smtp;
our $verbose;
our $use_ssl = @SMTP_USE_SSL@;

&init;

# Initialize package
sub init {
    $verbose = 0;
}

# Package functions

sub CheckAddr {
    (my $addr) = @_;
    chomp $addr;

    return ($addr =~ m/^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2}|[A-Z]{3}|[A-Z]{4}|[A-Z]{5}|[A-Z]{6})$/i);
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
            $smtp->datasend($s."\r\n");
	}
    }
}

# Set up a connection to the SMTP server so email can be sent
# No actual connection is created in local debug mode.
sub OpenMail {
    if ($local_debug) {
	print "<pre>\r\n";
        return 1
    }
    $smtp = Net::SMTP->new('@SMTP_HOST@',
       Hello => '@THISHOST@',
       SSL => @SMTP_USE_SSL@,
       Port => @SMTP_PORT@,
       Timeout => 5
    );
    if (!defined($smtp)) {
        print $@, $cr;
        return 0
    }
    print 'Connecting to: ', $smtp->domain, $cr;
    if (@SMTP_STARTTLS@) {
        if (!$smtp->starttls(SSL_verify_mode => SSL_VERIFY_NONE)) {
            print 'STARTTLS failed', $cr;
            print $@, $cr;
            return 0
        }
    }
    if ('@SMTP_AUTH_USER@' ne '') {
        if (!$smtp->auth('@SMTP_AUTH_USER@', '@SMTP_AUTH_PASSWD@')) {
            print 'Authentication for @SMTP_AUTH_USER@ failed.', $cr;
            print $@, $cr;
            return 0
        }
    }
    print 'Connection established, sending mail...', $cr;
    1
}

sub MailFrom {
    (my $sender) = @_;
    if (!$smtp->mail($sender)) {
        print $@, $cr;
    }
}

sub MailTo {
    if (!$smtp->recipient(@_)) {
        print $@, $cr;
    }
}

sub StartMailData {
    if (!$smtp->data()) {
        print $@, $cr;
    }
}
sub EndMailData {
    if (!$smtp->dataend()) {
        print $@, $cr;
    }
}

# Close the connection to the SMTP server.
sub CloseMail {
    if ($local_debug) {
	print '</pre>';
    } else {
        $smtp->quit();
    }
}

sub SendHeader {
    my $header = shift @_;
    my $first = 1;
    my $text = '';
    foreach my $section (@_) {
	# print 'Section: ', $section;
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
    # print $header, ': ', $text;
}
 
1; #ok
