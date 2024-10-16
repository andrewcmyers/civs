package b2r;

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
my $LOCAL_CW_OPT = 1;

# Order candidates by number of ballots on which they are top-ranked.
# However, if multiple choices are tied for top rank, they each get
# only fractional credit.
#

# Count the number of times each candidate is found in
# the nth rank on a ballot.
sub compute_rank_counts {
    my ($n, $ballots) = @_;
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
        foreach my $rank (@ballot) {
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
            my $adj_rank = $rerank[$rank];
            my $count = $rank_count[$adj_rank];

            # print (join ":", @ballot), "\n" if ($count == 0) ;

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

    my $log = '<ul>';
    my $rank_counts = &compute_rank_counts($n, $ballots);

    sub choice_name {
        $choices->[shift];
    }

    if ($debug) {
        for (my $i = 0; $i < $n; $i++) {
            print choice_name($i), ": ";
            for (my $r = 0; $r < $n; $r++) {
                if ($r != 0) { print ", " }
                print $rank_counts->[$i][$r] // 0;
            }
            print "\n";
        }
    }


    my @unranked_choices = (0..($n-1));
    my @rankings = ();

    if ($debug) {
        print "Unsorted: ", ((join ", ", (map {&choice_name($_)} @unranked_choices)), "\n")
    }
    @unranked_choices = sort {&compare_choice_ranks($a, $b, $n, $rank_counts)} @unranked_choices;

    print 
        "choices in seeded order: ",
        (join ( ", ", (map {&choice_name($_)} @unranked_choices))),
        "\n" if $debug;
    $log .=  "<li>Choices in seeded order: <ol><li>".
        (join ( "<li>&nbsp;", (map {&choice_name($_)} @unranked_choices))).
        "<br>\n";
    $log .= "</ol>";
    my $num_ranked = 0;

    while ($#unranked_choices > 0) {
        my $r = $num_ranked+1;
        $log .= "<li>Rank $r:<br>";
        my @remaining_choices = @unranked_choices;

# Optimistically hope we have a local CW
        my @sorted1 = sort {&compare_choice_ranks($a, $b, $n, $rank_counts)} @remaining_choices;
        my $top = $sorted1[0];
        my $local_cw = 1;
        foreach my $c (@sorted1) {
            next if $c == $top;
            if ($matrix->[$c][$top] >
                $matrix->[$top][$c]) {
                $local_cw = 0;
                last;
            }
        }
        my $winner;
        if ($local_cw && $LOCAL_CW_OPT) {
            $winner = $top;
            if ($debug) {
                print "Picking local CW\n";
            }
            $log .= "Local CW chosen: ".&choice_name($winner)."\n";
        } else {
            while ($#remaining_choices > 0) {
                my @sorted = sort {compare_choice_ranks($a, $b, $n, $rank_counts)} @remaining_choices;
                my $m = $#remaining_choices;
                my $c1 = $sorted[$m-1];
                my $c2 = $sorted[$m];

                print "<li>Comparing preferences of ",
                    &choice_name($c1), " and ",
                    &choice_name($c2), ". " if $debug;
                $log .= "Comparing preferences of @{[&choice_name($c1)]} and @{[&choice_name($c2)]}.<br>\n";

                my $n1 = $matrix->[$c1][$c2];
                my $n2 = $matrix->[$c2][$c1];
                my $loser;

                if ($n1 > $n2) {
                    $loser = $c2;
                    print &choice_name($c1), " wins.\n" if $debug;
                    $log .= "@{[&choice_name($c1)]} wins.<br>\n";
                } elsif ($n1 < $n2) {
                    $loser = $c1;
                    $log .= "@{[&choice_name($c2)]} wins.<br>\n";
                } else {
                    # tiebreaking using ordering
                    $loser = $c2;
                }
                my @nr;
                foreach my $c3 (@remaining_choices) {
                    if ($c3 != $loser) {
                        push @nr, $c3
                    }
                }
                @remaining_choices = @nr;
            }
            $winner = $remaining_choices[0];
            $log .= "@{[&choice_name($winner)]} wins this round.";
        }
        push @rankings, [$winner];
        $num_ranked++;
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
