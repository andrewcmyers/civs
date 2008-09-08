package runoff;

use CGI qw(:standard);
use civs_common;
use strict;

# rank_candidates($n, $mref, $bref) : construct a ranking of the choices.
#
# Arguments:
#   n is the number of choices
#   mref is a reference to an n x n preference matrix
#   bref is a reference to a list of ballots, where each ballot
#     is a reference to a list containing the ranking of the candidates.
#
# Returns: a list ($rankings, $log), where:
#   $rankings is a reference to a list of references to lists. An element
#     in the outer list is a rank (from highest/most preferred to
#     lowest/least preferred) and each inner list contains the
#     indices of choices. 
#   $log is an HTML log (string) giving details of how the algorithm worked.
#
# Requires:
#     The matrix referenced by $mref is consistent with the ballots
#     referenced by $bref, and mref is the right shape (as defined by $n).
#     Some ballots may not have entries for all $n candidates, because of
#     write-ins.
#
sub rank_candidates {
    my ($n, $mref, $bref, $choices) = @_;

    # print pre('ranking candidates');

    my @result = ();
    my @ranked = ();
    my $num_ranked = 0;
    my @ballots = @{$bref}; # ugh -- is there a way to avoid this?

    my $log = '<ul>';

    while ($num_ranked < $n) {
        # Look for a Condorcet winner or top tied set among the
	# active (non-ranked, non-rejected) choices
	if (0 && $num_ranked % 5 == 0) {
	    print "$num_ranked...";
	    STDOUT->flush();
	}
	$log .= '<li>Rank '.($num_ranked+1).': ';
	my $cw = -1;
	my @rejected = ();
	my $rejected_any = 0;
	my $num_active = $n - $num_ranked;
	while (1) {
	    # look for a CW among the active choices
	    # print pre("Looking for CW among $num_active active choices");
	    for (my $j = 0; $j < $n; $j++) {
		if ($ranked[$j] || $rejected[$j]) { next; }
		my $notcw = 0;
		for (my $k = 0; $k < $n; $k++) {
		    if (!$ranked[$k] &&
			  !$rejected[$k] &&
			  $j != $k &&
			  $mref->[$j][$k] <= $mref->[$k][$j]) {
			$notcw = 1;
			# print pre("$choices->[$j] not CW because of $choices->[$k]");
			last;
		    }
		}
		if (!$notcw) {
		    $cw = $j;
		    last;
		}
	    }
	    if ($cw >= 0) {
		# Add the CW to the ranks.
		$ranked[$cw] = 1;
		$num_ranked++;
		push @result, [($cw)];
		if (!$rejected_any) {
		    $log .= "Found CW $choices->[$cw] immediately.";
		} else {
		    $log .= ". Found CW $choices->[$cw].";
		}
		# print pre("Next rank: $cw"), $cr;
		last; # break out of while (1)
	    } else {
		# No CW yet. Reject the choices with the lowest number
		# of top-position rankings among the choices not ranked so far.
		my $worst_top_count = $#ballots + 1;
		my $num_worst = 0;
		my @top_count = ();

		for (my $j = 0; $j < $n; $j++) {
		    if ($ranked[$j] || $rejected[$j]) { next; }
		    foreach $b (@ballots) {
			my $rank = $b->[$j];
			if ($rank == 0) { next; }
			my $inc = 1;
			for (my $k = 0; $k < $n; $k++) {
			    if (!$ranked[$k] &&
				!$rejected[$k] &&
				$b->[$k] != 0 &&
				$b->[$k] < $b->[$j]) {
				$inc = 0;
				last;
			    }
			}
			$top_count[$j] += $inc;
		    }
		    if ($top_count[$j] < $worst_top_count) {
			$worst_top_count = $top_count[$j];
			$num_worst = 1;
		    } elsif ($top_count[$j] == $worst_top_count) {
			$num_worst++;
		    }
		}
		if ($num_active == $num_worst) {
		    # everyone left is equally good -- no one to reject, just
		    # take them all at this rank.
		    my @top_tied = ();
		    for (my $j = 0; $j < $n; $j++) {
			if (!$rejected[$j] && !$ranked[$j]) {
			    if ($top_count[$j] != $worst_top_count) {
				# print pre("error in runoff algorithm");
			    }
			    # print pre("Ranking tied: $j"), $cr;
			    push @top_tied, $j;
			    $ranked[$j] = 1;
			    $num_ranked++;
			}
		    }
		    push @result, [@top_tied];
		    if (!$rejected_any) {
			$log .= 'Found top tied set immediately.';
		    }
		    last; # break out of while (1)
		} else {
		    # randomly drop one of the people tied for smallest number
		    # of top ranks and try again to find a Condorcet winner
		    my @losers = ();
		    for (my $j = 0; $j < $n; $j++) {
			if ($top_count[$j] == $worst_top_count &&
			    !$ranked[$j] && !$rejected[$j]) {
			    push @losers, $j;
			}
		    }
		    &fisher_yates_shuffle(\@losers);
		    if ($#losers < 0) {
			print pre('no one to drop?');
			die;
		    }
		    $rejected[$losers[0]] = 1;
		    $num_active--;
		    # print pre("Randomly dropping $choices->[$losers[0]]"), $cr;
		    if (!$rejected_any) {
			$log .= 'Ignored ';
		    } else {
			$log .= ', ';
		    }
		    $log .= $choices->[$losers[0]];
		    if ($#losers > 0) { $log .= ' (random choice)'; }
		    $rejected_any = 1;
		}
	    }
	}
    }
    $log .= '</ul>';

    return (\@result, $log);
}

# print_details($log, $n, $choices, $choice_index):
# Print out to RESULTS the details of the election algorithm, using the
# information in $log that was returned by rank_candidates.
sub print_details {
    (my $log) = @_;
    print main::RESULTS $log;
}
 
1; # ok!
