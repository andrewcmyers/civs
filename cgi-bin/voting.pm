package voting;

use civs_common;
use CGI qw(:standard -utf8);
use election;
use strict;

# Print the ballot form for the question currently selected.
#
# $nav, if given, describes where this question sits in a poll that asks
# several: { question => index, count => how many, receipt => the ballot's
# receipt or '' }. Without it -- as when control previews a ballot, and
# for every poll asking a single question -- the form is what it has
# always been, with one submit button and no way to move between
# questions.
sub GenerateVoteForm {

    my ($voter_key, $authorization_key, $choice_index_ref, $rank_ref, $js_ui, $lean, $askforid, $nav) = @_;

    my @choice_index = @{$choice_index_ref};
    my @rank = @{$rank_ref};
    my $several = ($nav && $nav->{'count'} > 1);

    my $rating = $tx->Rank;
    if ($proportional eq 'yes' && $use_combined_ratings) {
	$rating = $tx->Weight;
    }

    print '<form method="post"
      action="@PROTO@://@THISHOST@'.$civs_bin_path.'/vote@PERLEXT@"
      enctype="multipart/form-data"
      name="CastVote"
      onsubmit="return doublecheck_ballot()">', $cr;

    if ($askforid) {
        print "<script>var voter_id_required = 1</script>\r\n";
        print p($tx->Identifier_request,
            '<input id="id_request" type="text" name="email_address" size="50"></p>'),
            "\r\n"
    }
    print hidden('key', $voter_key), $cr;
    print hidden('id', $election_id), $cr;
    print hidden('akey', $authorization_key), $cr;
    if ($nav) {
        print hidden(-name => 'q', -value => $nav->{'question'},
                     -override => 1), $cr;
        print hidden(-name => 'receipt', -value => $nav->{'receipt'},
                     -override => 1), $cr;
    }

    print '<table class="form" id="ballot" border="0" cellpadding="5" cellspacing="0"><tr><td>', $cr;

    print '<table cellpadding="5px" cellspacing="0" border="1" id="preftable">
    <tr class="heading">
	    <th>&nbsp;'.$tx->Choice.'&nbsp;</th>';
    if ($voting_enabled) {
	print '<th>'.$rating.'</th>';
    }
    print '</tr>',$cr;


#   print $cr, '<!-- Current rankings:', $cr;
#   for (my $i = 0; $i < $num_choices; $i++) {
#	$name = $choices[$i];
#	$name =~ s/"/ /;
#	my $selected = $rank[$i];
#	print "$i \"$choices[$i]\" $selected", $cr;
#    }
#    print "-->", $cr;

    for (my $i = 0; $i < $num_choices; $i++) {
	my $k = $choice_index[$i];
	my $selected = $rank[$k];
	my $choice = $choices[$k];
	if ($js_ui && $voting_enabled) {
	    print "<tr onclick=\"select_row(this, event.shiftKey||event.ctrlKey);\"><td class=\"choice\">$choice</td>", $cr;
	} else {
	    print "<tr><td class=inactive_choice>$choice</td>", $cr;
	}
	if ($voting_enabled) {
	    if ($proportional ne 'yes' || !$use_combined_ratings) {
		print "<td><select size=\"1\" name=\"C$k\" onchange=\"sort_rows()\">", $cr;
		for (my $j = 1; $j <= $num_choices; $j++) {
		    my $selattr;
		    my $ord = $tx->ordinal_of($j);
		    if ($j == $selected) { $selattr = ' selected="selected"' }
		    print "  <option value=\"$j\" label=\"$ord\" $selattr>$ord</option>", $cr;
		}
		if ($proportional ne 'yes' && $no_opinion eq 'yes') {
		    if ($selected eq "No opinion") {
			print '  <option selected="selected">No opinion</option>';
		    } else {
			print '  <option>No opinion</option>';
		    }
		}
		print '</select></td>', $cr;
	    } else {
		print '<td><input type="text" name="C'.$k.'"
		size="3" value="'. $selected. '"></td>';
	    }
	}
	print "</tr>", $cr;
    }
    print '</table></td>', $cr;
    if ($js_ui && !$lean && $voting_enabled) {
	print '<td rowspan="2" width="0" valign="top" align="left">
	    <input type="button" class="move_but" id="move_top" disabled="disabled" value="'.$tx->to_top.'"
                onclick="do_move_top()" /><br />
	    <input type="button" class="move_but" id="move_up" disabled="disabled" value="'.$tx->move_up.'"
                onclick="do_move_up()" /><br />
	    <input type="button" class="move_but" id="make_tie" disabled="disabled" value="'.$tx->make_tie.'"
                onclick="do_make_tie()" /><br />
	    <input type="button" class="move_but" id="move_down" disabled="disabled" value="'.$tx->move_down.'"
                onclick="do_move_down()" /><br />
	    <input type="button" class="move_but" id="move_bottom" disabled="disabled" value="'.$tx->to_bottom.'"
                onclick="do_move_bottom()" />
	    <table class="form"><tr><td>
	    <p id="jsnohelp">',
	    $tx->buttons_are_deactivated,
	    '</p>
	    <div style="display: none" id="jshelp">',
	    $tx->ranking_instructions,
	    '</div>
	    </td></tr></table>
	    </td>', $cr;
    }

    print '</tr>', $cr;


    if ($voting_enabled) {
	print '<tr><td style="height: 100%">', $cr;
	if ($several) {
	    my $last = ($nav->{'question'} == $nav->{'count'} - 1);
	    # Going back only navigates: it does not record the question
	    # being left, so that a voter who has not made up their mind
	    # cannot be recorded as having answered it by looking away.
	    # Neither of these records a ballot, so they turn off the
	    # checks doublecheck_ballot makes of one.
	    my $no_ballot = ' onclick="window.skip_ballot_checks = true"';
	    if ($nav->{'question'} > 0) {
		print '<input class="ballot_nav" type="submit" value="'
		    . $tx->Previous_question . '" name="Previous"'
		    . $no_ballot . ' />', $cr;
	    }
	    # Same action either way; but on a question already answered,
	    # moving past it throws that answer away, which "skip" does
	    # not convey.
	    print '<input class="ballot_nav" type="submit" value="'
		. ($nav->{'answered'} ? $tx->Discard_answer
				      : $tx->Skip_question)
		. '" name="Skip"' . $no_ballot . ' />', $cr;
	    print '<input id="vote" type="submit" value="'
		. ($last ? $tx->Finish_voting : $tx->Next_question)
		. '" name="Vote" />', $cr;
	} else {
	    print '<input id="vote" type="submit" value="'
		. $tx->submit_ranking . '" name="Vote" />', $cr;
	}
	print '</td></tr>', $cr;
    }

    print '</table>', $cr;
    print '</form>', $cr;

    if ($writeins eq 'yes') {
	print $cr, '<form method="post"
	    action="@PROTO@://@THISHOST@'.$civs_bin_path.'/vote@PERLEXT@"
	    enctype="multipart/form-data"
	    name="AddWritein">', $cr;
	print '<p>', $tx->write_in_a_choice, $cr,
	    ' <input type="text" size="60" name="writein" />';
	print '<input type="submit" value="', $tx->Add_writein, '" name="AddWritein" /></p>', $cr;
	print hidden('key', $voter_key);
	print hidden('id', $election_id);
	print hidden('akey', $authorization_key);
	if ($nav) {
	    print hidden(-name => 'q', -value => $nav->{'question'},
			 -override => 1);
	    print hidden(-name => 'receipt', -value => $nav->{'receipt'},
			 -override => 1);
	}
	print '</form>', $cr;
    }

    print span({-style => 'display: none', -id=>'doublecheck_msg'}, $tx->doublecheck_msg);
    print span({-style => 'display: none', -id=>'need_id_msg'}, $tx->Need_identifier);
}

1;
