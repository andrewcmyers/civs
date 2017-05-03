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
    (my $a, my $b) = @_;
    (($b->[1] - $b->[2]) <=> ($a->[1] - $a->[2]))
    ||
    ($a->[1] <=> $b->[1])
}
sub compare_defeats_sort { compare_defeats($a, $b) }

# compare_candidates($def1, $def2, $ranked):
# compare two candidates based on their current lists of defeats, provided as
# array references.  The individual defeats in the list must be sorted in
# order of decreasing strength. A candidate is considered 'stronger' if
# its defeats are weaker.
# Any defeat involving a ranked candidate (as defined by @{$ranked}) is
# invalid and should be ignored. Such defeats may be removed from the
# the list when encountered.
sub compare_candidates {
    (my $def1, my $def2, my $ranked) = @_;

    my $i = 0, my $j = 0;
    my $d1, my $d2;

    while (1) {
        while ($i < @{$def1} && $ranked->[$i]->[0]) {
            $i++;
        }
        while ($j < @{$def2} && $ranked->[$j]->[0]) {
            $j++;
        }
        my $undef1 = ($i < @{$def1});
        my $undef2 = ($j < @{$def2});
        return $undef1 <=> $undef2 if ($undef1 || $undef2);

        my $cmp = &compare_defeats($def1->[$i], $def2->[$j]);

        return $cmp if $cmp;

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
            if ($matrix->[$i][$j] <= $matrix->[$j][$i]) {
                push @def, [($j, $matrix->[$j][$i], $matrix->[$i][$j])];
# note: includes all defeats and ties
            }
        }
        $defeats->[$i] = [ sort compare_defeats_sort @def ];
    }
    
    my @ranked; # which choices are already ranked

    while ($num_ranked < $n) {
        my @best;
        my $minimax;
        for (my $i = 0; $i < $n; $i++) {
            next if $ranked[$i];

            my $idefs = $defeats->[$i];
            my $d;
            if (!@{$idefs}) {
                @best = ($i);
                #$log .= "  undefeated best: $i<br>";
                last
            } else {
                if (!@best || &compare_defeats($d, $minimax) > 0) {
                    @best = ($i);
                    $minimax = $d;
                    #$log .= "  new best: $i<br>";
                } elsif (@best && &compare_defeats($d, $minimax) == 0) {
                    push @best, $i;
                    #$log .= "  tied best: $i<br>";
                } else {
                    #$log .= "  not the current best<br>";
                }
            }
        }
        foreach my $i (@best) {
            $ranked[$i] = 1;
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
    (my $log) = @_;
    print main::RESULTS $log;
}
 
1; # ok!
