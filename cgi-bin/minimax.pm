package minimax;

use strict;

# rank_candidates($n, $matrix, $ballots) : construct a ranking of the choices.
#
# Arguments:
#   n is the number of choices
#   matrix is a reference to an n x n preference matrix
#   ballots is a reference to a list of ballots, where each ballot
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
#     The matrix referenced by $matrix is consistent with the ballots
#     referenced by $ballots, and matrix is the right shape (as defined by $n).
#     Some ballots may not have entries for all $n candidates, because of
#     write-ins.
#

# order defeats by weakness.
sub compare_defeats {
    my ($a, $b) = @_;
    (($b->[1] - $b->[2]) <=> ($a->[1] - $a->[2]))
    ||
    ($a->[1] <=> $b->[1])
}
sub compare_defeats_sort { compare_defeats($a, $b) }

sub defeat_to_string {
    my ($d) = @_;
    "vs. $d->[0] : ($d->[1] - $d->[2]) "
}

sub defeats_to_string {
    my ($defs) = @_;
    my $result = '';
    $result = "undefeated" if !@{$defs};
    foreach my $d (@{$defs}) {
        $result .= defeat_to_string($d)
    }
    $result
}

# compare_candidates($def1, $def2, $ranked):
# compare two candidates based on their current lists of defeats, provided as
# array references.  The individual defeats in the list must be sorted in
# order of decreasing strength. A candidate is considered 'stronger' if
# its defeats are weaker.
# Any defeat involving a ranked candidate (as defined by @{$ranked}) is
# invalid and should be ignored. Such defeats may be removed from the
# the list when encountered.
sub compare_candidates {
    my ($d1, $d2, $ranked) = @_;

    my $i = 0, my $j = 0;

    while (1) {
        while ($i < @{$d1} && $ranked->[$d1->[$i]->[0]]) {
            splice @{$d1}, $i, 1;
        }
        while ($j < @{$d2} && $ranked->[$d2->[$j]->[0]]) {
            splice @{$d2}, $j, 1;
        }
        my $u1 = ($i >= @{$d1});
        my $u2 = ($j >= @{$d2});
        return $u1 <=> $u2 if ($u1 || $u2);

        my $cmp = &compare_defeats($d1->[$i], $d2->[$j]);
        return $cmp if $cmp != 0;

        $i++;
        $j++;
    }
}

sub rank_candidates {
    my ($n, $matrix, $ballots, $choices) = @_;

    my @rankings = ();
    my @ranked = ();
    my $num_ranked = 0;

    my $log = '<ul>';

    my $defeats = [()];

# construct sorted lists of defeats for each choice: O(n^2 log n)
    for (my $i = 0; $i < $n; $i++) {
        my @def;
        for (my $j = 0; $j < $n; $j++) {
            next if $i == $j;
            push @def, [($j, $matrix->[$j][$i], $matrix->[$i][$j])];
        }
        $defeats->[$i] = [ sort compare_defeats_sort @def ];
    }

    my @ranked; # which choices are already ranked

    while ($num_ranked < $n) {
        my @best;
        for (my $i = 0; $i < $n; $i++) {
            next if $ranked[$i];
            #$log .= "choice $i: " . &defeats_to_string($defeats->[$i]) . "<br>\r\n";
            if (!@best) {
                 #$log .= "  first unranked: $i<br>";
                @best = ($i);
                if (@{$defeats->[$i]}) {
                    next
                } else {
                     #$log .= "  undefeated! $i<br>";
                    last
                }
            }
            my $j = $best[0];
            #$log .= "  comparing $i against current best: $j " . &defeats_to_string($defeats->[$j]) . "<br>";

            my $cmp = &compare_candidates($defeats->[$i], $defeats->[$j], \@ranked);

            if ($cmp > 0) {
                @best = ($i);
                #$log .= "  new best: $i<br>";
            } elsif ($cmp == 0) {
                push @best, $i;
                #$log .= "  tied best: $i<br>";
            }
            # else { $log .= "  not the current best<br>"; }
        }
        my $r = $num_ranked+1;
        $log .= "<li>Rank $r:<br>";
        foreach my $i (@best) {
            $ranked[$i] = 1;
            my $nm = $choices->[$i];
            $log .= "&nbsp;&nbsp;$nm ($i): " . &defeats_to_string($defeats->[$i]) . "<br>";
        }
        push @rankings, \@best;
        $num_ranked += @best;
    }
    return (\@rankings, $log . '</ul>');
}

# print_details($log, $n, $choices, $choice_index):
# Print out to RESULTS the details of the election algorithm, using the
# information in $log that was returned by rank_candidates.
sub print_details {
    my ($log) = @_;
    print main::RESULTS $log;
}

1; # ok!
