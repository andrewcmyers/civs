package minimax;

use CGI qw(:standard);
use civs_common;
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
    $a->[1] == $b->[1] ? 
            $a->[2] <=> $b->[2]
          : $b->[1] <=> $a->[1]
}
sub compare_defeats_sort { compare_defeats($a, $b) }

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
        #$log .= "picking rank $num_ranked<br>";
        for (my $i = 0; $i < $n; $i++) {
            next if $ranked[$i];
            #$log .= "considering $i<br>";

            my $idefs = $defeats->[$i];
            my $j = 0;
            for (; $j <= $#{$idefs}; $j++) {
                my $d = $idefs->[$j];
                if (!$ranked[$d->[0]]) { last }
            }
            if ($j > $#{$idefs}) {
                @best = ($i);
                #$log .= "  undefeated: $i<br>";
                last
            } else {
                my $d = $idefs->[$j];
                if ($#best == -1 ||
                &compare_defeats($d, $minimax) > 0) {
                    @best = ($i);
                    $minimax = $d;
                    #$log .= "  new best: $i<br>";
                } elsif ($#best != -1 &&
                    &compare_defeats($d, $minimax) == 0) {
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
        $num_ranked += $#best + 1;
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
