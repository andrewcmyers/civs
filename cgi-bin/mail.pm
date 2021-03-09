package mail;   # should be CIVS::Mail

# This package is a wrapper around Net::SMTP.

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
                      &GetOptouts &SaveOptOuts &RemoveOptOut
                      &HasOptOuts &SetOptOutPatterns &CheckOptOutSender
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

    return ($addr =~ m/^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2,8})$/i);
}

sub TrimAddr {
    (my $addr) = @_;
    $addr =~ s/^(\s)+//;
    $addr =~ s/(\s)+$//;
    $addr =~ s/\s+/ /;
    return $addr;
}

sub CanonicalizeAddr {
    (my $addr) = @_;
    $addr = TrimAddr($addr);
    $addr = lc $addr;
    if ($addr =~ m/\@gmail.com$/) { # remove . from gmail addresses
        (my $base) = $addr =~ m/^([^@]*)\@gmail.com/;
        $base =~ s/\.//g;
        $addr = $base.'@gmail.com';
    }
    return $addr;
}

my $optout_file = "@CIVSDATADIR@/do-not-email.txt";


# Return a reference to a hash mapping the hashes of
# all the email addresses that have opted out to a
# reference to an array of blocked sender addresses.
sub GetOptouts {
    my %optouts;
    if (-r $optout_file) {
        undef $/;
        open(OPTOUTS, "<$optout_file");
        my $data = <OPTOUTS>;
        close(OPTOUTS);
        my @a = split /[\r\n]+/, $data;
        foreach my $line (@a) {
            (my $hash, my $rest) = split / /, $line, 2;
            if ($rest eq '') {
                $rest = "*" # backward compatibility
            }
            my @patterns = split / /, $rest;
            $optouts{$hash} = \@patterns;
            # print "Opted out: ", $hash, $cr;
        }
    }
    return \%optouts
}

sub SaveOptOuts {
    my ($optouts) = @_;
    open (OPTOUTS, ">$optout_file") || print "<i>Internal error saving opt-out information</i>", $cr;
    foreach my $h (keys %$optouts) {
        if (defined($optouts->{$h})) {
            my @patterns = @{$optouts->{$h}};
            print OPTOUTS "$h @patterns\n"
        }
    }
    close(OPTOUTS);
}

sub optout_key {
    civs_hash($_[0])
}

# Does this receiver have any opt-outs defined?
sub HasOptOuts {
    my ($optouts, $receiver) = @_;
    $receiver = &CanonicalizeAddr($receiver);
    return defined($optouts->{optout_key($receiver)});
}

# Report whether receiver has opted out from mail from sender.
# Return 1 if so, 0 otherwise.
sub CheckOptOutSender {
    my ($optouts, $receiver, $sender) = @_;
    $receiver = &CanonicalizeAddr($receiver);
    $sender = &CanonicalizeAddr($sender);
    my $mapping = $optouts->{optout_key($receiver)};
    if (!defined($mapping)) {
        return 0;
    }
    my @patterns = @{$mapping};
    foreach my $p (@patterns) {
        if ($p eq '*') { return 1 }
        $p =~ s/\./\\./g;
        $p =~ s/\*/.*/g;
        $p = "\\A$p\\Z";
        # print "Checking '$sender' against pattern '$p'\n";
        if ($sender =~ m[$p]) { return 1 }
    }
    return 0;
}

# return whether an opt-out pattern is valid
sub VerifyOptoutPattern {
    (my $pattern) = @_;
    if ($pattern =~ m/\A[a-zA-Z0-9\.*@]+\Z/) {
        return 1;
    } else {
        return 0;
    }
}

# Record patterns for a given receiving user.
# Requires: patterns is a string containing
# space-separated patterns, which need not
# be valid (invalid ones will be ignored).
# If there are no valid patterns then the
# catch-all pattern * is recorded.
sub SetOptOutPatterns {
    (my $optouts, my $receiver, my $patterns) = @_;
    my @patarr = split / +/, $patterns;
    my @valid_pats = ();
    for my $p (@patarr) {
        if (&VerifyOptoutPattern($p)) {
            push @valid_pats, $p;
        }
    }
    if ($#valid_pats == -1) {
        @valid_pats = ('*');
    }
    $receiver = &CanonicalizeAddr($receiver);
    $optouts->{optout_key($receiver)} = \@valid_pats;
    return "@valid_pats";
}

sub RemoveOptOut {
    (my $optouts, my $addr) = @_;
    $addr = &CanonicalizeAddr($addr);
    delete $optouts->{optout_key($addr)};
}

sub Send {
    foreach my $s (@_) {
	if ($verbose || $local_debug) {
	    print CGI::escapeHTML($s)."\n"; STDOUT->flush();
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
    # print 'Connected to: ', $smtp->domain, $cr;
    if (@SMTP_STARTTLS@) {
        if (!$smtp->starttls(SSL_verify_mode => SSL_VERIFY_NONE)) {
            print 'STARTTLS failed:', $smtp->message(), $cr;
            return 0
        }
    }
    if ('@SMTP_AUTH_USER@' ne '') {
        if (!$smtp->auth('@SMTP_AUTH_USER@', '@SMTP_AUTH_PASSWD@')) {
            print 'Authentication for @SMTP_AUTH_USER@ failed.',
               $smtp->message(), $cr;
            return 0
        }
    }
    1
}

sub MailFrom {
    (my $sender) = @_;
    if ($local_debug) {
        print "From ", $sender, $cr;
    } elsif (!$smtp->mail($sender)) {
        print "MailFrom:", $smtp->message(), $cr;
        return 0
    }
    1
}

sub MailTo {
    if ($local_debug) {
        print "To ", $_[0], $cr;
    } elsif (!$smtp->recipient(@_)) {
        print "To: ", $smtp->message(), $cr;
        return 0
    }
    1
}

sub StartMailData {
    if ($local_debug) {
        print "--- Mail data begins ---", $cr;
    } elsif (!$smtp->data()) {
        print "StartMailData:", $smtp->message(), $cr;
        return 0
    }
    1
}
sub EndMailData {
    if ($local_debug) {
        print "--- Mail data ends ---", $cr;
    } elsif (!$smtp->dataend()) {
        print "EndMailData: ", $smtp->message(), $cr;
        return 0
    }
    1
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
