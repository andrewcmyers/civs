package english;

sub lang { return 'en-US'; }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    return 'Condorcet Internet Voting Service';
}
sub about_civs {
    return 'About CIVS';
}
sub create_new_poll {
    return 'Create new poll';
}
sub about_security_and_privacy {
    return 'About security and privacy';
}
sub FAQ {
    return 'FAQ';
}
sub CIVS_suggestion_box {
    return 'CIVS suggestion box';
}
sub unable_to_process {
    return 'CIVS is unable to process your request because of an internal error.';
}

# civs_create

sub mail_has_been_sent {
    return "Mail has been sent to the address you provided (<tt>$_[1]</tt>).";
}

sub click_on_the_URL_to_start {
    return "Click on the URL in that email to start the poll: <strong>$_[1]</strong>.";
}

sub here_is_the_control_URL {
    return 'Here is the URL to control the new poll. In ordinary operation
             this would be sent to the supervisor via e-mail.';
}
sub the_poll_is_in_progress {
    return 'The poll is in progress. Press this button to end it: ';
}

sub CIVS_Poll_Creation {
    return "CIVS Poll Creation";
}
sub Poll_created {
    return "Poll created: $_[1]"
}

# start

sub poll_started {
    return 'The poll '.strong($_[1]).' has been started.';
}

# control

sub CIVS_Poll_Control {
    return "CIVS Poll Control";
}
sub Poll_control {
    return "Poll Control";
}
sub poll_has_not_yet_started {
    return 'The poll has not yet started. Press this button to start it: ';
}
sub start_poll {
    return 'Start poll';
}
sub ending_poll_cannot_be_undone {
    return 'Ending a poll is an operation that cannot be undone. Continue?';
}
sub writeins_have_been_disabled {
    return 'Write-in choices have been disabled';
}
sub disallow_further_writeins {
    return 'Write-in choices have been disabled';
}
sub voting_disabled_during_writeins {
    return 'Voting is currently disabled during the write-in phase.';
}
sub allow_voting_during_writeins {
    return "Allow voting during write-in phase";
}
sub this_is_a_test_poll {
    return 'This is a test poll.';
}

sub poll_supervisor { # name, email
    return "Poll supervisor: $_[1] (<tt>$_[2]</tt>)";
}
sub no_authorized_yet { #waiting
    return "0 ($_[1] voters will be authorized when the poll is started)";
}
sub total_authorized_voters { # num_auth_string
    return "Total authorized voters: $_[1]";
}
sub actual_votes_so_far { # num
 return "Actual votes cast thus far: $_[1]";
}

sub poll_ends { # end
    return "Poll ends $_[1].";
}

# vote

sub page_header_CIVS_Vote { # election_title
    return 'CIVS Vote: '.$_[1];
}

sub winners_text {
    if ($_[1] == 1) {
	return "single favorite choice";
    } else {
	return "$num_winners favorite choices";
    }
}
sub ballot_reporting_is_enabled {
    return 'Ballot reporting is enabled for this poll.
	    Your ballot (the rankings you assign to candidates)
	    will be made public when the poll is closed.';
}
sub instructions1 { # winners_text, end, name, email
    return "Only the $_[1] will win the poll.<p>
	    The poll ends <b>$_[2]</b>.
	    The poll supervisor is $_[3] (<tt>$_[4]</tt>).
	    Contact the poll supervisor if you need help.";
}
sub instructions2 { #no_opinion, proportional, combined_ratings, civs_url
    my ($no_opinion, my $prop, my $combined, my $civs_url) = @_;
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
	if ($proportional) {
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
sub Rank {
    return 'Rank';
}
sub Choice {
    return 'Choice';
}
sub Weight {
    return 'Weight';
}

sub address_will_be_visible {
    return '<strong>Your email address will be visible</strong> along with your ballot.';
}

sub ballot_will_be_anonymous {
    return ' However, your ballot will still be anonymous: '
	 . 'no personally identifying information will appear.';
}

sub submit_ranking {
    return 'Submit ranking';
}

sub only_writeins_are_permitted {
    return 'Voting is not yet permitted in this poll. However,
             you may view the available choices and write in new
	     choices. Use the text field below to write in new choices.';
}

sub to_top {
    return 'to top';
}
sub to_bottom {
    return 'to bottom';
}
sub move_up {
    return 'move up';
}
sub move_down {
    return 'move down';
}
sub make_tie {
    return 'make tie';
}
sub buttons_are_deactivated {
    return 'These buttons are deactivated because
	your browser does not support Javascript.';
}
sub ranking_instructions {
    return
       'Rank the choices in one of three ways:
	<ol>
	    <li>drag the rows
	    <li>use pulldowns in Rank column
	    <li>select rows and use buttons above
	</ol>';
}

sub write_in_a_choice {
    return 'Write in a new choice: ';
}
sub if_you_have_already_voted { #url
    return "If you have already voted, you may see
	<a href=\"$_[1]\">the current poll results</a>.";
}
sub thank_you_for_voting { #title, receipt
    return "Thank you. Your vote for <strong>$_[1]</strong> has been
	successfully cast. Your voter receipt is ". code($_[2]).".";
}
sub name_of_writein_is_empty {
    return "Name of write-in choice is empty";
}
sub writein_too_similar {
    return "Sorry, the name of the write-in is too similar to an existing choice";
}

# results

1; # package succeeded!
