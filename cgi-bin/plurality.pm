package plurality;

use strict;
use b2r;

# rank_candidates($n, $matrix, $ballots, $choices) : construct a ranking of the choices.
#
# Arguments:
#   n is the number of choices
#   matrix is a reference to an n x n preference matrix
#   ballots is a reference to a list of ballots, where each ballot
#     is a reference to a list containing the ranking of the candidates.
#   choices is a reference to a list of choice names
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

my $debug = 0;

sub sort_by_top_rank {
    my ($a, $b, $n, $rank_counts) = @_;
    $rank_counts->[$b][0] <=> $rank_counts->[$a][0]
}

sub rank_candidates {
    my ($n, $matrix, $ballots, $choices) = @_;

    my $rank_counts = &b2r::compute_rank_counts($n, $ballots);

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

    my @unranked_choices = (0..($n-1));
    my @rankings = ();

    if ($debug) {
        print "Unsorted: ", ((join ", ", (map {$choices->[$_]} @unranked_choices)), "\n")
    }
    @unranked_choices = sort {&sort_by_top_rank($a, $b, $n, $rank_counts)} @unranked_choices;

    my $current_count = -1;
    foreach my $i (@unranked_choices) {
        if ($rank_counts->[$i][0] != $current_count) {
            push @rankings, [$i];
            $current_count = $rank_counts->[$i][0];
        } else {
            push @{@rankings[$#rankings]}, $i;
        }
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
