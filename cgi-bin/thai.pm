package thai;

use base_language;

our $VERSION = 1.00;
our @ISA = ('base_language'); # go to base_language module for missing methods
use CGI qw(:standard -utf8);
use utf8;

sub lang { 'th'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub style_file {
    'style.css';
}
sub Condorcet_Internet_Voting_Service {
    'บริการโหวตทางอินเทอร์เน็ตแบบ Condorcet (CIVS)';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # charset may be limited
    'Condorcet Internet Voting Service';
}
sub about_civs {
    'เกี่ยวกับ CIVS';
}
sub public_polls {
    'โพลสาธารณะ';
}
sub create_new_poll {
    'สร้างโพลใหม่'
}
sub about_security_and_privacy {
    'เกี่ยวกับความปลอดภัยและความเป็นส่วนตัว';
}
sub FAQ {
    'คำถามถามบ่อย';
}
sub CIVS_suggestion_box {
    'กล่องรับความคิดเห็น CIVS';
}
sub unable_to_process {
    'ระบบไม่สามารถดำเนินการตามคำขอของคุณได้เนื่องจากมีข้อขัดข้องภายในระบบ';
}
sub CIVS_Error {
    'ข้อผิดพลาดจาก CIVS';
}
sub CIVS_server_busy {
    'แม่ข่ายของระบบกำลังทำงานหนักในขณะนี้';
}
sub Sorry_the_server_is_busy {
    'ขออภัย แม่ข่ายของระบบถูกใช้งานหนักมากในขณะนี้และไม่สามารถรับคำร้องขอได้มากกว่านี้ โปรดลองใช้บริการใหม่ในภายหลัง';
}

# civs_create

sub mail_has_been_sent {
    "เราได้ส่งอีเมลไปยังที่อยู่ที่คุณให้มาแล้ว (<tt>$_[1]</tt>)";
}

sub click_on_the_URL_to_start {
    "กรุณากดลิงก์ในอีเมลเพื่อเริ่มโพล &ldquo;$_[1]&rdquo;.";
}

sub here_is_the_control_URL {
    'ลิงก์นี้ใช้สำหรับควบคุมโพลใหม่ โดยปกติแล้วระบบจะส่งลิงก์นี้ไปยังผู้ดูแลโพลทางอีเมล';
}
sub the_poll_is_in_progress {
    'โพลยังคงเปิดอยู่ กดปุ่มนี้เพื่อหยุดการลงคะแนนเพิ่มเติม: ';
}

sub CIVS_Poll_Creation {
    "การสร้างโพล CIVS";
}
sub Poll_created {
    "โพล $_[1] ได้ถูกสร้างขึ้นแล้ว"
}

sub Address_unacceptable { #addr
    "ที่อยู่ \"$_[1]\" ผิดรูปแบบจากที่ระบบต้องการ";
}
sub Poll_must_have_two_choices {
    'โพลต้องมีอย่างน้อยสองตัวเลือก';
}
sub Poll_directory_not_writeable {
    "สารบบโพลไม่สามารถบันทึกข้อมูลได้ ณ ขณะนี้";
}
sub CIVS_poll_created {
 "โพล CIVS $_[1] ได้ถูกสร้างขึ้นแล้ว";
}
sub creation_email_info1 { # title, url
"อีเมลนี้แจ้งให้ท่านทราบว่าโพล $_[1] ได้ถูกสร้างแล้ว  คุณคือผู้ดูแลโพลนี้  โปรดใช้ที่อยู่นี้ในการเริ่มและหยุดโพล:

  $_[2]

โปรดเก็บอีเมลนี้ไว้เป็นการส่วนตัวในที่ที่ปลอดภัย  หากคุณทำอีเมลฉบับนี้หาย คุณจะไม่สามารถควบคุมโพลนี้ได้

";
}
sub creation_email_public_link { # url
"เนื่องจากโพลนี้เป็นโพลสาธารณะ ท่านสามารถส่งลิงก์นี้ให้กับผู้ลงคะแนนได้โดยตรง:

  $_[1]

";
}
sub for_more_information_about_CIVS { # url
"ดูข้อมูลเพิ่มเติมเกี่ยวกับบริการโหวตทางอินเทอร์เน็ตแบบ Condorcet ได้ที่
  $_[1]";
}

sub Sending_result_key { # addr
    "<p>กำลังส่ง result key ไปยัง <tt>$_[1]</tt>  โปรดรอการยืนยันความถูกต้อง...<br>"
}
sub Done_sending_result_key { # addr
    '...ส่ง result key เรียบร้อยแล้ว</p>'
}
sub Results_of_CIVS_poll { # title
    "ผลของโพล CIVS: $_[1]";
}
sub Results_key_email_body { # title, url, civs_home
"ระบบได้สร้างโพล CIVS ใหม่ชื่อ \"$_[1]\" เรียบร้อยแล้ว
คุณได้รับอนุญาตจากระบบให้ดูผลโพลนี้ได้

โปรดเก็บอีเมลนี้ไว้ในที่ที่ปลอดภัย  หากคุณทำอีเมลฉบับนี้หาย คุณจะไม่สามารถดูผลโพลนี้ได้ คุณสามารถดูผลโพลนี้ได้จากที่อยู่นี้หลังจากโพลปิดแล้ว:

  $_[2]

ที่อยู่นี้เป็นความลับ ผู้ใช้ใดๆ ที่ได้รับที่อยู่นี้จะสามารถดูผลโพลได้ โปรดรักษาความเป็นส่วนบุคคลของที่อยู่ที่ท่านได้รับ

";
}

# start

sub poll_started {
    'โพล <strong>'.$_[1].'</strong> ได้เริ่มขึ้นแล้ว';
}

sub sending_keys_now {
    'Sending voter invitations now. Do not navigate away from this page
     until all invitations are sent.'
}

# control

sub CIVS_Poll_Control {
    "ควบคุมโพล CIVS";
}
sub Poll_control {
    "ควบคุมโพล";
}
sub poll_has_not_yet_started {
    'โพลยังไม่ได้เริ่ม กดปุ่มนี้เพื่ออนุมัติการลงมติ: ';
}
sub Start_poll {
    'เริ่มโพล';
}
sub End_poll {
    'จบโพล';
}
sub Edit_button {
    'แก้ไข'
}
sub Save_button {
    'บันทึก'
}
sub Remove_button {
    'ลบออก'
}
sub ending_poll_cannot_be_undone {
    'Ending a poll is an operation that cannot be undone. Continue?';
}
sub writeins_have_been_disabled {
    'Write-in choices have been disabled';
}
sub disallow_further_writeins {
    'Disallow further write-ins';
}
sub voting_disabled_during_writeins {
    'Voting is currently disabled during the write-in phase.';
}
sub allow_voting_during_writeins {
    "Allow voting during write-in phase";
}
sub this_is_a_test_poll {
    'This is a test poll.'
}
sub file_to_upload_from {
    'File to upload ballots from:'
}
sub Load_ballots {
    'Load ballots'
}
sub poll_supervisor { # name, email
    "Poll supervisor: $_[1] <tt>&lt;$_[2]&gt;</tt>"
}
sub no_authorized_yet { #waiting
    "0 ($_[1] voters will be authorized when the poll is started)";
}
sub total_authorized_voters { # num_auth_string
    "Total authorized voters: $_[1]";
}
sub actual_votes_so_far { # num
    "Actual votes cast thus far: $_[1]";
}
sub poll_ends { # end
    "Poll ends $_[1].";
}
sub Poll_results_available_to_all_voters_when_poll_completes {
    'Poll results available to all voters when poll completes.';
}
sub Voters_can_choose_No_opinion {
    'Voters can choose &ldquo;No opinion&rdquo;.';
}
sub Voting_is_disabled_during_writeins {
    'Voting is disabled during the write-in period.';
}
sub Poll_results_will_be_available_to_the_following_users {
    'Poll results will be available only to the following users:';
}
sub Poll_results_are_now_available_to_the_following_users {
    'Poll results are now available only to the following users,
	    who were earlier sent an email containing a URL for
	     viewing results:';
}
sub results_available_to_the_following_users {
    'The results of this poll have been released only to a limited set of users:';
}

sub Poll_results_are_available { #url
    "<a href=\"$_[1]\">See poll results</a>";
}
sub Description {
    'Description:';
}
sub Candidates {
    'Candidates:';
}
sub Add_voters {
    'Add voters';
}

sub the_top_n_will_win { # num_winners
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt = "choice";
    } else {
	$wintxt = "$_[1] choices";
    }
    return "The top $wintxt will win.";
}

sub add_voter_instructions {
    "Enter e-mail addresses of voters, one per line. These
    may be new voters or existing voters who have not voted yet.
    In a private poll, giving the e-mail address of an already
    existing voter <strong>will not</strong> let that voter vote twice.
    It will only resend the voter an invitation to vote.
    In a public poll, only a token attempt is made to prevent
    multiple voting.";
}
sub Upload_file {
    'Upload file: ';
}
sub Load_ballot_data {
    'Load ballot data';
}
sub File_to_upload_ballots_from {
    'File to upload ballots from:';
}
sub Upload_instructions {
    'Upload a text file formatted with one ballot per line. Each
      line contains the ranks of the N choices, which are numbers from 1
      to N, or a dash (<kbd>-</kbd>) to represent no opinion. Ranks should be
      separated by whitespace or a comma. Lines may be terminated
      with LF or CR/LF. Whitespace is ignored; lines whose first
      non-whitespace character is # are also ignored. A line may begin
      with <i>m</i><kbd>X</kbd> where <i>m</i> is a number, which
      signifies <i>m</i> identical ballots described by the rest of
      the line.'
}
sub Examples_of_ballots {
    'Examples of ballots:'
}
sub Ballot_examples {
    '1,4,3,2,5        <i>A simple ballot ranking five choices.</i>
    5 - 2 - 3        <i>Another ranking of five choices. Dashes indicate unranked choices.</i>
    8X1 4 3 2 5      <i>Eight ballots like the first example ballot.</i>'
}
sub Or_paste_this_code {
    'Or paste this HTML code into your own web page:'
}
sub This_is_a_public_poll_plus_link {
    my ($self, $url, $pub) = @_;
    if ($pub) {
	return "This is a public poll. Share the following link
	    with voters to allow them to vote:</p><p>
	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>. This
	    poll will also be publicized by CIVS.";
    } else {
	return "This is a public poll. Share the following link
	    with voters to allow them to vote:</p><p>
	    &nbsp;&nbsp;<tt><a href=\"$url\">$url</a></tt>";
    }
}
sub The_poll_has_ended {
    'The poll has ended.';
}

# add voters

sub CIVS_Adding_Voters {
    'CIVS: Adding Voters';
}
sub Adding_voters {
    'Adding voters';
}

sub Sorry_voters_can_only_be_added_to_poll_in_progress {
    'Sorry, voters can only be added to an poll in progress.';
}

sub Total_of_x_voters_authorized { # x
    if ($_[1] == 0) {
	'No voters authorized to vote yet.';
    } elsif ($_[1] == 1) {
	'Only 1 voter authorized to vote so far.';
    } else {
	"Total of $_[1] voters authorized to vote.";
    }
}

sub Go_back_to_poll_control {
    'Go back to poll control';
}
sub Done {
    'Done.';
}

# vote

sub page_header_CIVS_Vote { # election_title
    'CIVS Vote: '.$_[1];
}

sub ballot_reporting_is_enabled {
    'Ballot reporting is enabled for this poll.
     Your ballot (the rankings you assign to choices)
     will be made public when the poll ends.';
}
sub instructions1 { # num_winners, end, name, email
    my $wintxt;
    if ($_[1] == 1) {
	$wintxt="single favorite choice";
    } else {
	$wintxt="$_[1] favorite choices";
    }
    "Only the $wintxt will win the poll.<br />
	    The poll ends <b>$_[2]</b>.
	    The poll supervisor is $_[3] (<tt>$_[4]</tt>).
	    Contact the poll supervisor if you need help.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($self, $no_opinion, $prop, $combined, $civs_url) = @_;
    my $ret;
    if (!$prop || !$combined) {
	$ret = "Give each of the following choices
	    a rank, where a smaller-numbered rank means that you
	    prefer that choice more.
	    For example, give your top choice the rank 1.
	    Give choices the same rank if you have no
	    preference between them. You do not have to use all the
	    possible ranks. All choices initially have the
	    lowest possible rank. ". $cr;
	if ($no_opinion) {
	    $ret .= '<b>Note:</b> &ldquo;No opinion&rdquo;
		    is <i>not</i> the same as the lowest possible rank; it means
		    that you choose not to rank this choice with respect to the
		    other choices.</p>';
	}
	if ($prop) {
	    $ret .= '<p>This poll is decided using an experimental Condorcet-based
	    method designed to provide proportional representation. It is assumed
	    by the voting algorithm that you want the ranking of your most
	    preferred <i>winning</i> choice to be as high as possible, and if two
	    sets of winning choices agree on the choice you prefer most, then you
	    would decide between them using the second most preferred choice, and
	    so on. ';
	}
    } else {
	$ret = '<p>This poll is decided using an experimental
	Condorcet-based algorithm designed to provide proportional
	representation.
	Please give each of the following choices a
	<b>weight</b> that expresses how much you want that
	choice to be part of the winning set of choices.
	It is assumed by the voting algorithm that you want
	  the sum of weights of winning choices to be as large
	as possible.  All choices
	are currently given a weight of zero, meaning that you
	have no interest in seeing them win.
	Weights cannot be negative or larger than 999.
	It doesn\'t help you to make your weights larger
	than other voters\' weights, because your weights are only compared
	against each other.'.
	"<a href=\"$civs_url/proportional.html\">[See more information]</a>.</p>";
    }
    return $ret;
}

sub Identifier_request {
    "<p>Please give your email address or other recognizable identifier:  \r\n".
    '<input type="text" name="email_address" size="50"></p>'.
    "\r\n"
}

sub Rank { 'Rank' }
sub Choice { 'Choice' }
sub Weight { 'Weight' }

sub ordinal_of {
    "$_[1]"
}

sub address_will_be_visible {
    '<strong>Your email address will be visible</strong> along with your ballot.';
}

sub however_results_restricted {
    my @users = @{$_[1]};
    my $r = ' However, results will be made available only to a limited set of users: ';
    my $first=1;
    foreach my $u (@users) {
	if (!$first) { $r .= ', '; $first=0; }
	$r .= "<tt>$u</tt>";
    }
    $r .= '.';
    return $r;
}

sub ballot_will_be_anonymous {
    ' However, your ballot will still be anonymous:
      no personally identifying information will appear.'
}

sub submit_ranking {
    'Submit ranking';
}

sub only_writeins_are_permitted {
    'Voting is not yet permitted in this poll. However,
             you may view the available choices and write in new
	     choices. Use the text field below to write in new choices.';
}

sub Add_writein {
    'Add write-in';
}

sub to_top {
    'to top';
}
sub to_bottom {
    'to bottom';
}
sub move_up {
    'move up';
}
sub move_down {
    'move down';
}
sub make_tie {
    'make tie';
}
sub buttons_are_deactivated {
    'These buttons are deactivated because
	your browser does not support Javascript.';
}
sub ranking_instructions {
       '<p>Rank the choices in one of three ways:</p>
	<ol>
	    <li>drag the rows
	    <li>use pulldowns in Rank column
	    <li>select rows and use buttons above
	</ol>';
}

sub write_in_a_choice {
    'Write in a new choice: ';
}
sub if_you_have_already_voted { #url
    "If you have already voted, you may see
	<a href=\"$_[1]\">the current poll results</a>.";
}
sub thank_you_for_voting { #title, receipt
    "Thank you. Your vote for <strong>$_[1]</strong> has been
	successfully cast. Your voter receipt is <code>$_[2]</code>.";
}
sub try_some_public_polls {
    "If you still feel like voting, try one of these public polls:"
}
sub name_of_writein_is_empty {
    "Name of write-in choice is empty";
}
sub writein_too_similar {
    "Sorry, the name of the write-in is too similar to an existing choice";
}

# election

sub No_poll_ID {
    "No poll ID was provided. Perhaps a copy-paste error?"
}
sub Ill_formed_poll_ID {
    "An ill-formed poll identifier was provided. Perhaps a copy-paste error? (" . $_[1] . ")"
}
sub vote_has_already_been_cast {
    "A vote has already been cast using your voter key.";
}
sub following_URL_will_report_results {
    'The following URL will report poll results once the poll ends:';
}
sub following_URL_reports_results {
    'The following URL reports the current poll results:';
}
sub Already_voted {
    'Already voted';
}
sub Error {
    'Error';
}
sub Invalid_key {
    'Invalid key. You should have received a correct URL for
        controlling the poll by email. This error has been logged.';
}
sub Authorization_failure {
    'Authorization failure';
}

sub already_ended { # title
    "This poll (<strong>$_[1]</strong>) has already been ended.";
}
sub Poll_not_yet_ended {
    "Poll not yet ended";
}
sub The_poll_has_not_yet_been_ended { #title, name, email
    "This poll ($_[1]) has not yet been ended by its supervisor,
    $_[2] ($_[3]).";
}
sub The_results_of_this_completed_poll_are_here {
    'The results of this completed poll are here:';
}

sub No_write_access_to_lock_poll {
    "Did not have the write access needed to lock the poll.";
}
sub This_poll_has_already_been_started { # title
    "This poll ($_[1]) has already been started.";
}
sub No_write_access_to_start_poll {
    'Did not have write access to start a poll.';
}
sub Poll_does_not_exist_or_not_started {
    'This poll does not exist or has not been started.';
}
sub Your_voter_key_is_invalid__check_mail { # voter
   my $voter = $_[1];
   if ($voter ne '') {
    "Your voter key is invalid, $voter.
     You should have received a correct URL by email.";
   } else {
    "Your voter key is invalid. You should have received a correct URL by email.";
   }
}
sub Invalid_result_key { # key
    "Invalid result key: \"$_[1]\". You should have received a correct URL for
        viewing poll results by email. This error has been logged.";
}
sub Invalid_control_key { # key
    "Invalid control key. You should have received a correct URL for controlling the poll by email. This error has been logged.";
}
sub Invalid_voting_key {
    "Invalid voting key. You should have received a correct URL for voting by email. This error has been logged.";
}
sub Invalid_poll_id {
    "Invalid poll identifier";
}
sub Poll_id_not_valid { #id
    "The poll identifier \"$_[1]\" is not valid.";
}
sub Unable_to_append_to_poll_log {
    "Unable to append to the poll log.";
}
sub Voter_v_already_authorized {
    "Voter \"$_[1]\" is already authorized.
     The voter's key will be resent to the voter.";
}
sub Invalid_email_address_hdr { # addr
    "Invalid email address";
}
sub Invalid_email_address { # addr
    "Invalid email address: $_[1]";
}
sub Sending_mail_to_voter_v {
    "Sending mail to voter \"$_[1]\"...";
}
sub CIVS_poll_supervisor { # name
    "\"$_[1], CIVS poll supervisor\""
}
sub voter_mail_intro { #title, name, email_addr
"A Condorcet Internet Voting Service poll named <b>$_[1]</b> has been created.
You have been designated as a voter by the poll supervisor,
$_[2] (<a href=\"mailto:$_[3] ($_[2])\">$_[3]</a>).</p>";
}
sub Description_of_poll {
    'Description of poll:';
}
sub if_you_would_like_to_vote_please_visit {
    'If you would like to vote, please visit the following URL:';
}
sub This_is_your_private_URL {
'This is your private URL. Do not give it to anyone else, because they could use
it to vote for you.';
}
sub Your_privacy_will_not_be_violated {
'Your privacy will not be violated by voting.  The voting service has already
destroyed the record of your email address and will not release any information
about whether or how you have voted.';
}
sub This_is_a_nonanonymous_poll {
'The poll supervisor has decided to make this a <strong>non-anonymous poll</strong>.  If
you vote, your email address and how you voted will be visible to anyone who has been given
access to the poll results.  If you do not vote, the poll supervisor will also be able
to determine this.';
}

sub poll_has_been_announced_to_end { #election_end
    "The poll has been announced to end $_[1].";
}

sub To_view_the_results_at_the_end {
    "To view the results of the poll once it has ended, visit:</p> $_[1]";
}

sub For_more_information {
    "For more information about the Condorcet Internet Voting Service, see:\r\n$_[1]"
}

sub poll_email_subject { # title
    "Poll: $_[1]"
}

# close

sub CIVS_Ending_Poll {
    'CIVS: Ending Poll';
}

sub Ending_poll {
    'Ending a poll';
}
sub View_poll_results {
    'View poll results';
}
sub Poll_ended { #title
    "Poll ended: $_[1]";
}

sub The_poll_has_been_ended { #election_end
    "The poll has been ended. It was announced to end $_[1].";
}

sub poll_results_available_to_authorized_users {
    'The poll results are now available to authorized users.';
}

sub was_not_able_stop_the_poll {
    'Was not able to stop the poll';
}


# results

sub CIVS_poll_result {
    "CIVS poll result";
}
sub Poll_results { # title
    "Poll Results: $_[1]";
}

sub Writeins_currently_allowed {
    'Write-in choices are currently allowed.';
}

sub Writeins_allowed {
    'Write-in choices are allowed.';
}
sub Writeins_not_allowed {
    'Write-in choices are not allowed.';
}
sub Detailed_ballot_reporting_enabled {
    'Detailed ballot reporting is enabled.';
}
sub Detailed_ballot_reporting_disabled {
    'Detailed ballot reporting is disabled.';
}
sub Voter_identities_will_be_kept_anonymous {
    'Voter identities will be kept anonymous';
}
sub Voter_identities_will_be_public {
    'Voter identities (email) along with their ballots will be
visible to those authorized to see poll results.';
}
sub Condorcet_completion_rule {
    'Condorcet completion rule:';
}
sub undefined_algorithm {
    'Error: undefined algorithm.';
}
sub computing_results {
    'Computing results...';
}
sub Supervisor { #name, email
    "Supervisor: $_[1] <tt>&lt;$_[2]&gt;</tt>";
}
sub Announced_end_of_poll {
    "Announced end of poll: $_[1]";
}
sub Actual_time_poll_closed { # close time
    if ($_[1] == 0) {
	"Actual time poll closed: $_[1]"
    } else {
	'Actual time poll closed: <script>document.write(new Date(' .
	    $_[1] * 1000 .
	    ').toLocaleString())</script>';
    }
}
sub Poll_not_ended {
    'Poll has not yet ended.';
}
sub This_is_a_test_poll {
    'This is a test poll.';
}
sub This_is_a_private_poll { #num_auth
    "Private poll ($_[1] authorized voters)";
}
sub This_is_a_public_poll {
    'This is a public poll.';
}

sub Actual_votes_cast { #num_votes
    "Actual votes cast: $_[1]";
}
sub Number_of_winning_candidates {
    'Number of winning choices: ';
}
sub Poll_actually_has { #winmsg
    my $winmsg = '1 winner';
    if ($_[1] != 1) {
	$winmsg = $real_nwin.' winners';
    }
    "&nbsp;(Poll actually has $winmsg)";
}
sub poll_description_hdr {
    'Poll description';
}
sub Ranking_result {
    'Result';
}
sub x_beats_y { # x y w l
    "$_[1] beats $_[2] $_[3]&ndash;$_[4]";
}
sub x_ties_y { # x y w l
    "$_[1] ties $_[2] $_[3]&ndash;$_[4]";
}
sub x_loses_to_y { # x y w l
    "$_[1] loses to $_[2] $_[3]&ndash;$_[4]";
}
sub some_result_details_not_shown {
    'For simplicity, some details of the poll result are not shown. &nbsp;';
}
sub Show_details {
    'Show details';
}
sub Hide_details {
    'Hide details';
}
sub Result_details {
    'Result details';
}
sub Ballot_report {
    'Ballot report'
}
sub Ballots_are_shown_in_random_order {
    "Ballots are shown in a randomly generated order.";
}
sub Download_ballots_as_a_CSV { # url
    "[<a href=\"$_[1]\">Download ballots in CSV format</a>]";
}
sub No_ballots_were_cast {
    "No ballots were cast in this poll.";
}
sub Ballot_reporting_was_not_enabled {
    "Ballot reporting was not enabled for this poll.";
}
sub Tied {
    "<i>Tied</i>:";
}
sub loss_explanation { # loss_to, for, against
    ', loses to '. $_[1].' by '. $_[2] .'&ndash;'. $_[3];
}
sub loss_explanation2 {
    '&nbsp;&nbsp;loses to '.$_[1].' by '.$_[2].'&ndash;'.$_[3];
}
sub Condorcet_winner_explanation {
    '&nbsp;&nbsp;(Condorcet winner: wins contests with all other choices)';
}
sub undefeated_explanation {
    '&nbsp;&nbsp;(Not defeated in any contest vs. another choice)';
}
sub Choices_shown_in_red_have_tied {
    "Choices shown in red have tied for being selected.
	You may wish to select among them randomly.";
}
sub Condorcet_winner {
    "Condorcet winner";
}
sub Choices_in_individual_pref_order {
    'Choices (in individual preference order)';
}

sub What_is_this { # url
    '&nbsp;&nbsp;&nbsp; <a href="' . $_[1]. '"><small>'. '(What is this?)</small></a>';
}

# rp

sub All_prefs_were_affirmed {
    'All preferences were affirmed. All
		  Condorcet methods will agree with this ranking.';
}

sub Presence_of_a_green_entry_etc {
    'The presence of a green entry below
	the diagonal (and a corresponding red one above)
	means that a preference was ignored because
	it conflicted with other, stronger preferences.';
}
sub Random_tie_breaking_used {
'Random tie breaking was used to
arrive at this ordering, as per the MAM
algorithm. This may have affected the ordering
of the choices.';
}
sub No_random_tie_breaking_used {
    'No random tie breaking was needed to arrive at this ordering.';
}

# beatpath

sub beatpath_matrix_explanation {
    'The following matrix shows the strength of the strongest
    beatpath connecting each pair of choices. Choice 1 is ranked above
    choice 2 if there is a stronger beatpath leading from 1 to 2
    than any leading from 2 to 1.';
}

sub no_pref {
    'none'
}

#rp

sub Some_voter_preferences_were_ignored {
    'Some voter preferences were ignored because they
     conflict with other, stronger preferences:'
}

sub preference_description {
    "The $_[1]&ndash;$_[2] preference for $_[3] over $_[4]."
}

## User activation

sub mail_address {
    'ที่อยู่อีเมล:'
}
sub new_user {
    'เปิดใช้งานผู้ใช้'
}
sub user_activation {
    'เปิดใช้งานผู้ใช้'
}
sub activation_code_subject {
    'รหัสเปิดใช้งานสำหรับการใช้ CIVS'
}
sub user_activation_instructions {
    my ($self, $mail_mgmt_url) = @_;
    p('หากต้องการลงคะแนนในแบบสำรวจ CIVS ส่วนตัว คุณต้องเลือกรับการสื่อสารทางอีเมลจากบริการ CIVS ไม่ได้จัดเก็บที่อยู่อีเมลของคุณ และไม่มีการส่งจดหมายอัตโนมัติ คุณจะได้รับอีเมลจากบริการเมื่อมีการร้องขออย่างชัดแจ้งจากผู้ดูแลการสำรวจ ซึ่งมีข้อมูลประจำตัวที่จำเป็นในการลงคะแนนในแบบสำรวจส่วนตัวหรือเพื่อดูผลการสำรวจ').
    p("หากต้องการเลือกใช้ โปรดป้อนที่อยู่อีเมลของคุณและคลิกปุ่มด้านล่าง จากนั้นคุณควรได้รับอีเมลที่มีรหัสเปิดใช้งาน โปรดทราบว่าหากคุณเลือกไม่รับอีเมลก่อนหน้านี้ คุณต้องใช้หน้าการจัดการอีเมลเพื่อเปิดใช้งานอีเมลอีกครั้ง หากคุณใช้บริการบล็อกอีเมล คุณอาจต้องอนุญาตที่อยู่อีเมล CIVS เป็นผู้ส่งที่ได้รับอนุญาต (".'@SUPERVISOR@'.")")
}
sub opt_in_label {
    'ขอรหัสเปิดใช้งาน'
}
sub activation_code {
    'รหัสเปิดใช้งาน: '
}
sub someone_has_requested_activation {
    my ($self, $address, $code, $mail_mgmt_url) = @_;
    "มีคนขอให้ระบบการลงคะแนน CIVS เปิดใช้งานที่อยู่อีเมล <$address>
สำหรับการลงคะแนนเลือกตั้ง ในการเปิดใช้งานที่อยู่นี้ คุณจะต้องใช้รหัสเปิดใช้งานต่อไปนี้:

     $code

หากคุณไม่ได้เป็นผู้ริเริ่มคำขอนี้ คุณสามารถเพิกเฉยต่ออีเมลนี้ได้

ควบคุมอีเมลจาก CIVS โดยใช้ลิงก์นี้: $mail_mgmt_url
"
}
sub already_activated {
    'ที่อยู่อีเมลนี้ถูกเปิดใช้งานแล้ว'
}
sub activation_successful
{
    'เปิดใช้งานที่อยู่อีเมลเรียบร้อยแล้ว'
}
sub pending_invites_hdr {
    'การเชิญสำรวจความคิดเห็นที่รอดำเนินการ:'
}
sub submit_activation_code {
    'เปิดใช้งานเสร็จสมบูรณ์'
}
1; # package succeeded!
