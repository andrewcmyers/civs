package send_result_key;

use strict;
use warnings;

# Export the package interface
BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.02;
    @ISA         = qw(Exporter);
    @EXPORT = qw(&SendResultKey);
}

# Package imports
use civs_common;
use CGI qw(:standard);
use POSIX qw(strftime);
use mail;
use Fcntl qw(:DEFAULT :flock);
use Digest::MD5 qw(md5_hex);

# TODO: merge back into election.pm once election.pm is
# made object-oriented.

####################################
# Send authorized result viewers an email containing the URL that
# allows viewing results.
sub SendResultKey {
    my ($election_id, $supervisor, $title, $result_addrs, $result_key) = @_;

    if (!$local_debug) { OpenMail }
    my @result_addrs = split /\s+/, $result_addrs;
    my $optouts = &GetOptouts();
    foreach my $addr (@result_addrs) {
	$addr = &TrimAddr($addr);
	if ($addr eq '') { next; }
	print $tx->Sending_result_key($addr);

	if (!(&CheckAddr($addr))) {
	    print p($tx->Invalid_email_address($addr));
	    next;
	}
        if (&CheckOptOutSender($optouts, $addr, $supervisor)) {
            print p($tx->opted_out($addr));
            next;
        }

        if (!$local_debug) {
            my $url = "@PROTO@://$thishost$civs_bin_path/results@PERLEXT@?id=$election_id&rkey=$result_key";
            my $civs_supervisor = '@SUPERVISOR@';
            MailFrom('@AUTH_SENDER@');
            MailTo($addr);
            StartMailData;
            SendHeader 'From', "$civs_supervisor (".
                $tx->Condorcet_Internet_Voting_Service_email_hdr.')';
            SendHeader 'To', $addr;
            SendHeader 'Subject', $tx->Results_of_CIVS_poll($title);
            SendHeader 'Content-Type', 'text/plain; charset="utf-8"';
            Send "";
            Send $tx->Results_key_email_body($title,$url);
            Send $tx->for_more_information_about_CIVS($civs_home);
            EndMailData;
        } else {
            print p('Here is the result key that would have been sent: ', $result_key);
        }
    }
    if (!$local_debug) { CloseMail }

    print $tx->Done_sending_result_key();
}
1; # ok!
