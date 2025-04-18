package mail;   # should be CIVS::Mail

# This package is a wrapper around Net::SMTP.

use strict;
use warnings;
use MIME::Base64;
use Authen::SASL;
use Net::SMTP;
use IO::Socket::SSL;
use Encode qw(encode decode);
use Fcntl;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&OpenMail &CloseMail &MailFrom &MailTo
                      &StartMailData &EndMailData &Send &SendHeader
                      &GetOptouts &SaveOptOuts &RemoveOptOut &UserActivated
                      &HasOptOuts &OptOutKey &SetOptOutPatterns &CheckOptOutSender
                      &CheckAddr &CanonicalizeAddr);
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

# Check whether the given address is an email address
sub CheckAddr {
    (my $addr) = @_;
    $addr = &TrimAddr($addr);

    return ($addr =~ m/^[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+(?:[A-Z]{2,18})$/i);
}

# Convert an email address into canonical form.  All whitespace is removed, the
# address is put into lower case, and dots are removed from gmail addresses. If
# the address contains a part in angle brackets, that part is extracted and
# canonicalized.  This transformation is idempotent.
sub CanonicalizeAddr {
    (my $addr) = @_;
    (my $inner_addr) = $addr =~ m/<(.*)>/;
    if ($inner_addr) { $addr = $inner_addr }
    $addr = lc $addr;
    $addr =~ s/\s+//g;
    if ($addr =~ m/\@gmail.com$/) { # remove . from gmail addresses
        (my $base) = $addr =~ m/^([^@]*)\@gmail.com/;
        if ($base) {
            $base =~ s/\.//g;
            $addr = $base.'@gmail.com';
        }
    }
    return $addr;
}

my $optout_file = "@CIVSDATADIR@/email-control.txt";

# Return a reference to a hash table that maps the hashes of
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
    my $temp_output = "$optout_file.$$";
    if (!sysopen OPTOUTS, $temp_output, O_WRONLY|O_CREAT|O_TRUNC) {
	&Log("Could not open top polls temp output file $temp_output");
        print "<i>Internal error saving opt-out information (open)</i>", $cr;
	return;
    }
    foreach my $h (keys %$optouts) {
        if (defined($optouts->{$h})) {
            my @patterns = @{$optouts->{$h}};
            print OPTOUTS $h, ' ', join(' ', @patterns), "\n";
        }
    }
    close(OPTOUTS);
    if (!rename($temp_output, $optout_file)) {
	&Log("Could not rename top polls temp output file $temp_output");
        print "<i>Internal error saving opt-out information (rename $temp_output $optout_file)</i>", $cr;
    }
}

# Returns the key for a canonicalized email address
sub OptOutKey {
    my $bytes = encode('utf-8', $_[0]);
    my $result = civs_hash('@EMAIL_SALT@' . $bytes);
    return $result;
}

# Is this receiver an activated user?
sub UserActivated {
    my ($optouts, $receiver) = @_;
    $receiver = &CanonicalizeAddr($receiver);
    return defined($optouts->{&OptOutKey($receiver)});
}

# Does this receiver have any opt-outs defined?
sub HasOptOuts {
    my ($optouts, $receiver) = @_;
    $receiver = &CanonicalizeAddr($receiver);
    my $mapping = $optouts->{&OptOutKey($receiver)};
    if (!defined($mapping)) { return 0 }
    my @patterns = @{$mapping};
    if ($#patterns == 0 && $patterns[0] eq '+') { return 0 }
    return 1;
}

# Report whether receiver has opted out from mail from sender.
# Return 1 if so, 0 otherwise.
sub CheckOptOutSender {
    my ($optouts, $receiver, $sender) = @_;
    $receiver = &CanonicalizeAddr($receiver);
    $sender = &CanonicalizeAddr($sender);
    my $mapping = $optouts->{OptOutKey($receiver)};
    if (!defined($mapping)) {
        return 0;
    }
    my @patterns = @{$mapping};
    foreach my $p (@patterns) {
        if ($p eq '+') { return 0 }
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
    if ($pattern eq '+') { return 1 }
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
    $optouts->{&OptOutKey($receiver)} = \@valid_pats;
    return "@valid_pats";
}

# Remove opt-out information for an address.
sub RemoveOptOut {
    (my $optouts, my $addr) = @_;
    $addr = &CanonicalizeAddr($addr);
    delete $optouts->{&OptOutKey($addr)};
}

# Send a sequence of bytes, represented as a string,
# to the mail server connection.
sub SendBytes {
    (my $s) = @_;
    if ($verbose || $local_debug) {
        print CGI::escapeHTML($s)."\n"; STDOUT->flush();
    }
    if (!($local_debug)) {
        $smtp->datasend($s);
    }
}

# Send a string to the mail server connection
sub Send {
    foreach my $s (@_) {
        SendBytes(encode('utf-8', $s."\r\n"))
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

sub EncodeHeaderValue {
    my $text = '';
    my $first = 1;
    my $header = shift @_;
    my $ascii_only = 1;
    foreach my $section (@_) {
	if (!$first) { $text .= "\r\n " }
	$first = 0;
	if ($section =~ m/[\x80-\x{10FFFF}]/) {
          $ascii_only = 0;
          if ($section =~ m/[\x{100}-\x{10FFFF}]/) {
            $section = encode('utf-8', $section);
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
            my $intro = '=?ISO-8859-1?Q?';
            my $budget = 75 - length($intro) - length($header) - 2;
            my $lines = 0;
            my $i = 0;
            for (; $i < length($section); $lines++) {
                my $enc = '';
                for (; $i < length($section) && $budget > 0; $i++) {
                    my $c = substr($section, $i, 1);
                    if ($c =~ m/^[\x20-\x7E]$/ && !($c =~ /[=\?_ ]/)) {
                        $enc .= $c;
                        $budget -= 1;
                    } else {
                        $enc .= '=' . (sprintf "%2X", ord($c));
                        $budget -= 3;
                    }
                }
                if ($lines != 0) { $text .= "\r\n " }
                $text .= $intro . $enc . '?=';
                $budget = 75 - length($intro) - 3;
            }
          }
	} else {
	    $text .= $section;
	}
    }
    return $text;
}

sub SendHeader {
    my $header = shift @_;
    SendBytes $header . ': ' . EncodeHeaderValue($header, @_). "\r\n";
    # print $header, ': ', $text;
}

1; #ok
