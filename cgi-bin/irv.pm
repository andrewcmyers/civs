package irv;

use strict;

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

# Order candidates by number of ballots on which they are top-ranked.
# However, if multiple choices are tied for top rank, they each get
# only fractional credit.
#

# Count the number of times each candidate is found in
# the nth rank on a ballot, ignoring candidates with
# a zero or absent value in the array @{$active}.
sub compute_rank_counts {
    my ($n, $ballots, $active) = @_;
    my @rank_counts;

    sub compare_ranks {
        (0 + $a) <=> (0 + $b)
    }

    foreach my $b (@{$ballots}) {
        my @ballot = @{$b};
        print "ballot: ", (join " ", @ballot), "\n" if $debug > 1;
        my $best_rank = $#ballot + 1;
        my $best_count = 0;
        my %ranks;
        for (my $i = 0; $i <= $#ballot; $i++) {
            next if !$active->[$i];
            my $rank = $ballot[$i];
            next if ($rank eq 'No opinion');
            $ranks{$rank}++;
        }
        my @keys = keys %ranks;
        my @sorted_ranks = sort compare_ranks @keys;
        # print "sorted: ", join "<", @sorted_ranks; print "\n";
        my @rerank, my @rank_count;
        for (my $i = 0; $i <= $#sorted_ranks; $i++) {
            my $rank = $sorted_ranks[$i];
            $rerank[$rank] = $i;
            $rank_count[$i] = $ranks{$rank};
        }
        print " reranked: ", join " ", @rerank, "\n" if $debug > 1;
        print " rank_count: ", join " ", @rank_count, "\n" if $debug > 1;
        for (my $i = 0; $i < $n; $i++) {
            my $rank = $ballot[$i];
            next if ($rank == "No opinion");
            next if !$active->[$i];
            my $adj_rank = $rerank[$rank];
            my $count = $rank_count[$adj_rank];

            if ($count == 0) {
                print STDERR "ZERO COUNT\n";
                print "ballot: ", (join ":", @ballot), "\n";
                print "rank_count: ", (join ",", @rank_count), "\n";
                exit 1;
            }

            $rank_counts[$i][$adj_rank] =
                $rank_counts[$i][$adj_rank] + (1.0/$count);
        }
    }
    return \@rank_counts;
}

# Compare two candidates based on how many top rankings
# they have. The rank counts are passed in an explicit
# argument to work around what looks like a scoping bug in Perl.
sub compare_choice_ranks {
    my ($a, $b, $n, $rank_counts) = @_;
    for (my $r = 0; $r < $n; $r++) {
        my $ac = $rank_counts->[$a][$r] // 0;
        my $bc = $rank_counts->[$b][$r] // 0;
        print "  Rank $r: $ac vs $bc\n" if $debug > 1;

        next if ($ac == $bc);
        return -($ac <=> $bc);
    }
    0;
}

sub rank_candidates {
    my ($n, $matrix, $ballots, $choices) = @_;

    sub choice_name {
        $choices->[shift];
    }


    my $log = '<ul>';

    my @unranked_choices = (0..($n-1));
    my @rankings = ();

    if ($debug) {
        print "Unsorted: ", ((join ", ", (map {choice_name($_)} @unranked_choices)), "\n")
    }

    while ($#unranked_choices > 0) {
        my @remaining_choices = @unranked_choices;

        while ($#remaining_choices > 0) {
            my @active;
            foreach my $choice (@remaining_choices) {
                $active[$choice] = 1;
            }
            my $rank_counts = &compute_rank_counts($n, $ballots, \@active);
            if ($debug) {
                print "Recomputed rank counts:\n";
                for (my $i = 0; $i < $n; $i++) {
                    next if !$active[$i];
                    print choice_name($i), ": ";
                    for (my $r = 0; $r < $n; $r++) {
                        if ($r != 0) { print ", " }
                        print $rank_counts->[$i][$r] // 0;
                    }
                    print "\n";
                }
            }

            my @sorted = sort {compare_choice_ranks($a, $b, $n, $rank_counts)} @remaining_choices;

            my $c = $sorted[$#remaining_choices];

            if ($debug) {
                print "Removing last-seeded $choices->[$c]\n";
            }
            my @nr;
            foreach my $choice (@remaining_choices) {
                push @nr, $choice if $choice != $c;
            }
            @remaining_choices = @nr;
        }
        my $winner = $remaining_choices[0];
        push @rankings, [$winner];
        print "Round won by ", &choice_name($winner), "\n" if $debug;
        my @uc;
        foreach my $c (@unranked_choices) {
            if ($c != $winner) {
                push @uc, $c
            }
        }
        @unranked_choices = @uc
    }
    push @rankings, [@unranked_choices];

    return (\@rankings, "")
}

# print_details($log, $n, $choices, $choice_index):
# Print out to RESULTS the details of the election algorithm, using the
# information in $log that was returned by rank_candidates.
sub print_details {
    my ($log) = @_;
    print main::RESULTS $log;
}

1; # ok!
