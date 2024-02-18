package runoff;

use CGI qw(:standard -utf8);
use strict;
use b2r;

# From the Perl Cookbook, p. 121
# Generate a random permutation of @array in place.
sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    return if $#{$array} < 1;
    for ($i = @$array; --$i; ) {
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}

# rank_candidates($n, $mref, $bref, $choices) : construct a ranking of the choices.
#
# Arguments:
#   $n is the number of choices
#   $mref is a reference to an n x n preference matrix
#   $bref is a reference to a list of ballots, where each ballot
#     is a reference to a list containing the ranking of the candidates.
#   $choices is a reference to a list of candidate names
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

my $debug = 0;

sub rank_candidates {
    my ($n, $mref, $bref, $choices) = @_;

    my @result = ();
    my @ranked = ();
    my $num_ranked = 0;
    my @ballots = @{$bref}; # ugh -- is there a way to avoid this?

    my $rank_counts = &b2r::compute_rank_counts($n, $bref);

    if ($debug) {
        for (my $i = 0; $i < $n; $i++) {
            print $choices->[$i], ": ";
            for (my $r = 0; $r < $n; $r++) {
                if ($r != 0) { print ", " }
                print $rank_counts->[$i][$r] // 0;
            }
            print "\n";
        }
    }
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
		# print("Now have CW: ", $choices->[$cw], "\n");
		last; # break out of while (1)
	    } else {
		# No CW yet. Reject the choices with the lowest number
		# of top-position rankings among the choices not ranked so far.
                my $worst_choice = -1;

		for (my $j = 0; $j < $n; $j++) {
		    if ($ranked[$j] || $rejected[$j]) { next; }
                    if ($worst_choice == -1) {
                        $worst_choice = $j;
                        # print("current worst is ", $choices->[$j], "\n");
                    } elsif (&b2r::compare_choice_ranks($j, $worst_choice, $n, $rank_counts) > 0)  {
                        $worst_choice = $j;
                        # print("current worst is ", $choices->[$j], "\n");
                    } else {
                        # print("Actually $choices->[$j] is better (",
                        # &b2r::compare_choice_ranks($j, $worst_choice, $n, $rank_counts),
                        # ")\n");
                    }
		}
                $rejected[$worst_choice] = 1;
                # print("Ignoring ", $choices->[$worst_choice], "\n");
                $num_active--;
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
