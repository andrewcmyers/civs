package rp;

# This package computes the CIVS Ranked Pairs and MAM rankings of
# candidates, by providing an appropriate rank_candidates function.
# See runoff.pm for a specification of this function.

use CGI qw(:standard);
use civs_common;
use strict;

our $mam; # whether MAM tiebreaking is to be used.
          # Otherwise, uses the deterministic CIVS Ranked Pairs
          # algorithm.

our @rvh; # Random voter hierarchy; used only for MAM tiebreaking.
          #   Contains 1's and 0's that encode a total order
	  #   on the choices.
our $tiebreak = 0;
          # whether the RVH was used to order majorities
our $use_strongest_defeat = 0;

# Note: MAM would pick a random ballot and use it to resolve ties in
# order_pairs. Here we don't try to achieve a total
# ordering, but instead group identical-strength pairs into
# "bunches".
sub order_pairs {
    my @pair_a = @{$a};
    my @pair_b = @{$b};
    if ($pair_a[2] != $pair_b[2]) {
	return $pair_b[2] <=> $pair_a[2];
    } elsif ($pair_a[3] != $pair_b[3]) {
	return $pair_a[3] <=> $pair_b[3];
    } elsif ($mam) {
	my $x = $pair_b[0];
	my $y = $pair_b[1];
	my $z = $pair_a[0];
	my $w = $pair_a[1];
	$tiebreak = 1;
	# print pre("Using MAM ordering extension\n");
	# print pre("$x-$y vs $z-$w\n");
	# print pre("matrix elements: ". $rvh[$w][$y]. " ". $rvh[$y][$w] . " ". 
		  # $rvh[$x][$z]. " ". $rvh[$z][$x]);
	if ($w != $y && $rvh[$w][$y] != $rvh[$y][$w]) {
	    return ($rvh[$w][$y] - $rvh[$y][$w]);
	}
	return ($rvh[$x][$z] - $rvh[$z][$x]);
    } else {
	return 0;
    }
}

sub unparse {
    if (!defined($_[0])) {
	return 'undefined';
    }
    my @p = @{$_[0]};
    return "($p[0] vs. $p[1] : $p[2]-$p[3])";
}

# Compute the transitive closure using the Floyd-Warshall
# algorithm. This is only used for debugging purposes.
sub Floyd_Warshall {
  (my $mref, my $n) = @_;
  my $update = 0;
  for (my $k = 0; $k < $n; $k++) {
    for (my $i = 0; $i < $n; $i++) {
      for (my $j = 0; $j < $n; $j++) {
# consider going from i to j via k
# m_ij = max(m_ij, min(s1,s2))
	if ($mref->[$i][$k] && $mref->[$k][$j] && !$mref->[$i][$j] &&
	    $i != $j) {
	    $mref->[$i][$j] = 1;
	    # print pre("Update $i, $j");
	    $update = 1;
	}
      }
    }
  }
  return $update;
}
 
# TransitiveClosure(m, winner, loser, n) adds the preference
# for winner over loser to the nxn matrix m and computes the
# transitive closure (in m). If this creates any new cycles,
# returns 1, otherwise 0. It uses a worklist algorithm because
# that is faster than a full Floyd-Warshall when the matrix
# is already pretty much done.
sub TransitiveClosure {
    my ($mref, my $winner, my $loser, my $num_choices) = @_;
    my $cycle = 0;
    my @worklist = ([($winner, $loser)]);
    while ($#worklist >= 0) {
	my $pair = shift @worklist;
	my $winner = $pair->[0];
	my $loser = $pair->[1];
	if ($mref->[$winner][$loser]) { next; }
	$mref->[$winner][$loser] = 1;
	if ($winner == $loser) { $cycle = 1; next; }
	for (my $j = 0; $j < $num_choices; $j++) {
	    if ($mref->[$loser][$j]) {
		push @worklist, [($winner, $j)];
	    }
	    if ($mref->[$j][$winner]) {
		push @worklist, [($j, $loser)];
	    }
	}
    }
    return $cycle;
}

# See runoff.pm for a spec of this subroutine
sub rank_candidates {
    my ($num_choices, $mref, $bref, $choices) = @_;
    my @ballots = @{$bref};
    fisher_yates_shuffle [@ballots];

    if ($main::algorithm eq 'mam') {
	$mam = 1;
	&create_RVH([@ballots], $num_choices);
    } else {
	    $mam = 0;
	}

    (my $rref, my $ciref, my $denied_any,
	my $allowed_cycle, my $denied_report) = 
	&rank_candidates_internal($mref, $num_choices, $choices);

    my $log = '';
    if (!$allowed_cycle && !$denied_any) {
	$log .= $tx->All_prefs_were_affirmed;
    }
    if ($denied_any) {
	$log .= p($tx->Presence_of_a_green_entry_etc);
	$log .= $denied_report;
    }
    if ($main::algorithm eq 'mam') {
	if ($tiebreak) {
	    $log .= p($tx->Random_tie_breaking_used);
	} else {
	    $log .= p($tx->No_random_tie_breaking_used);
	}
    }
    return ($rref, $log);
}

# rank_candidates(mref, num_choices) uses a ranked-pairs
# algorithm to ranks the "num_choices" choices
# according to the preference matrix in "mref". It returns
# a list ([@result], [@choice_index], $denied_any,
# $allowed_cycle, $denied_report)
# where "result" is a list of lists ranking all the choices,
# "choice_index" is a permutation of the choices consistent
# with "result", "denied_any" reports whether any
# preferences had to be denied to construct a ranking, and
# denied_report is HTML text explaining which preferences
# were denied and why.
sub rank_candidates_internal {
    (my $mref, my $num_choices, my $choices_ref) = @_;
    my @matrix = @{$mref};
    my @choices = @{$choices_ref};
    my @choice_index, my @result;
    my $denied_any = 0;
    my $allowed_cycle = 0;
    my $denied_report = '';

    my @pairs = ();
    my @affirmed, my @committed, my @current, my @saved_current;
    main::NewProgressPhase(0.1);
    for (my $j = 0; $j < $num_choices; $j++) {
	main::ReportProgress(($j + 1) / ($num_choices + 1));
	for (my $k = 0; $k < $num_choices; $k++) {
	    $committed[$j][$k] = 0;
	    $affirmed[$j][$k] = 0;
	    if ($matrix[$j][$k] > $matrix[$k][$j]) {
		push @pairs, [($j, $k, $matrix[$j][$k], $matrix[$k][$j])];
	    }
	}
    }
    @pairs = sort order_pairs @pairs;

    main::NewProgressPhase(1.0);

    my $last_pair = 'none'; # reference to the last pair considered
    my $bunch_index = 0; # Which of several identical-strength pairs this is.
                         # Typically zero.
#
# Note: Copying 2-D arrays with $a[$i] = [@{$b[$i]}] isn't any faster.
#
    my $count = 0;
    foreach my $pair_ref (@pairs) {
	$count++;
	main::ReportProgress(($count + 1) / ($#pairs + 1));
	my @pair = @{$pair_ref};
	(my $winner, my $loser, my $winvotes, my $losevotes) = @{$pair_ref};
	my $wname = $choices[$winner];
	my $lname = $choices[$loser];
	# print pre("Considering the $winvotes-$losevotes pref for $wname over $lname");
	#STDOUT->flush();
	$a = $last_pair; $b = $pair_ref;
	if ($last_pair eq 'none' || &order_pairs() < 0) {
# new bunch: commit the affirmed prefs from the previous bunch
	    for (my $j = 0; $j < $num_choices; $j++) {
		for (my $k = 0; $k < $num_choices; $k++) {
		    $committed[$j][$k] = $affirmed[$j][$k];
		}
	    }
	    $bunch_index = 0;
	} else {
	    if ($mam && ($last_pair ne 'none' && &order_pairs() != 0)) {
		die "Shouldn't get here.\n";
	    }
# in MAM mode we shouldn't get here, and sorting should ensure <= 0
	    # print pre("  same bunch!");
	    $bunch_index++;
	}
	$last_pair = $pair_ref;

	for (my $j = 0; $j < $num_choices; $j++) {
	    for (my $k = 0; $k < $num_choices; $k++) {
		$current[$j][$k] = $affirmed[$j][$k];
	    }
	}
# we take a preference if it doesn't create a new cycle when
# considered in combination with all strictly stronger


	my $cycle = TransitiveClosure [@current], $winner, $loser, $num_choices;

	if ($cycle && $bunch_index != 0) {
	    # print pre("creates a cycle, trying alone.");
# We have a cycle when considered with others in bunch but
# maybe not when considered alone. Try again only
# considering the strictly stronger preferences.
	    $cycle = 0;
	    my @temp;
	    for (my $j = 0; $j < $num_choices; $j++) {
		for (my $k = 0; $k < $num_choices; $k++) {
		    $temp[$j][$k] = $committed[$j][$k];
		}
	    }
	    $cycle = TransitiveClosure [@temp], $winner, $loser, $num_choices;
	    if (!$cycle) { $allowed_cycle = 1; }
	}
	if (!$cycle) {
	    for (my $j = 0; $j < $num_choices; $j++) {
		for (my $k = 0; $k < $num_choices; $k++) {
		    $affirmed[$j][$k] = $current[$j][$k];
		}
	    }
	} else {
	    if (!$denied_any) {
		$denied_report .=
		    p($tx->Some_voter_preferences_were_ignored).'<ul>';
		$denied_any = 1;
	    }
	    $denied_report .=
		li(p($tx->preference_description($pair[2], $pair[3],
		    				  $wname, $lname)));

	    # print pre("  denied.");
	}
	STDOUT->flush();
    }

    if ($denied_any) { $denied_report .= '</ul>'; }

    # Now find the candidates in the current group
    my $num_ranked = 0;
    my @already_ranked, my @ordering, my @rp_choice_index;
    while ($num_ranked < $num_choices) {
    # print '<hr>';
	my @group;
	my @in_group;
	for (my $i = 0; $i < $num_choices; $i++) {
	    if (!$already_ranked[$i]) {
		my $still_in = 1;
		for (my $j = 0; $j < $num_choices; $j++) {
		    if (!$already_ranked[$j]) {
			if ($affirmed[$j][$i] > $affirmed[$i][$j]) {
			    $still_in = 0;
			    last;
			}
		    }
		}
		if ($still_in) {
		    push @group, $i;
		    $in_group[$i] = 1;
		    # print pre("candidate group includes $i");
		}
	    }
	}
# find the strongest defeats of candidates within the group by
# candidates not yet ranked.
	my @strongest_defeat;
	foreach my $i (@group) {
	    # print pre("Computing SD of $i");
	    foreach (my $j = 0; $j < $num_choices; $j++) {
		if (!$already_ranked[$j]) {
		    if ($matrix[$j][$i] > $matrix[$i][$j]) {
# this is a defeat that should be considered. Is it the strongest?
			$b = [($j, $i, $matrix[$j][$i], $matrix[$i][$j])];
			if (!defined($strongest_defeat[$i])) {
			    $strongest_defeat[$i] = $b;
			    my $ub =&unparse($b); 
			    #print pre("  Initializing SD of $i to $ub");
			} else {
			    $a = $strongest_defeat[$i];
			    if (&order_pairs > 0) {
				$strongest_defeat[$i] = $b;
				my $ub =&unparse($b); 
				my $ua =&unparse($a); 
				# print pre("  Updating SD of $i to $ub (was $ua)");
			    }
			}
		    }
		}
	    }
	}
	my @winner;
	foreach my $i (@group) {
	    my $won = 1;
	    foreach my $j (@group) {
		$a = $strongest_defeat[$i];
		$b = $strongest_defeat[$j];
		my $ub =&unparse($b); 
		my $ua =&unparse($a); 
		if ($j == $i || !defined($a)) { next; }
		# print pre("comparing defeats of $i and $j : $ua and $ub");
		if (!defined($b) || &order_pairs < 0) {
		    # print pre("  Removing $i from group, stronger defeat than $j ($ua vs $ub)");
		    $won = 0;
		    last;
		}
	    }
	    if ($won) {
		my $ud = &unparse($strongest_defeat[$i]);
		# print pre("$i is in the next winner set, SD was $ud");
		push @winner, $i;
	    }
	}

	push @result, [@winner];
	foreach my $j (@winner) {
	    $rp_choice_index[$num_ranked++] = $j;
	    $already_ranked[$j] = 1;
	}
    }

    return ([@result], [@rp_choice_index],
	    $denied_any, $allowed_cycle, $denied_report);
}

# create_rvh(ballots, num_choices): using a list of ballots, randomly select
# ballots until a total order is constructed on all
# candidates (or as much of an order as can be constructed,
# anyway). (This is the "random voter hierarchy" in MAM parlance.)
sub create_RVH {
    (my $bref, my $num_choices) = @_;
    my @ballots = @{$bref};
    foreach my $rowref (@ballots) {
	my @row = @{$rowref};
	# print "$ballot\n";
	if ($#row != $num_choices-1) {
	    # print "Bad ballot, skipping: ".$ballot."\n";
	    next;
	}
	for (my $i = 0; $i < $num_choices; $i++) {
	    if ($row[$i] eq 'No opinion') { next; }
	    for (my $j = 0; $j < $num_choices; $j++) {
		if ($row[$j] eq 'No opinion') { next; }
		if ($row[$i] < $row[$j] &&
		    !$rvh[$i][$j] &&
		    !$rvh[$j][$i]) {
# a chance to try adding a preference for i over j
		    my @temp;
		    for (my $i = 0; $i < $num_choices; $i++) {
			for (my $j = 0; $j < $num_choices; $j++) {
			    $temp[$i][$j] = $rvh[$i][$j];
			}
		    }
		    my $cycle =
			TransitiveClosure [@temp], $i, $j, $num_choices;
		    if (!$cycle) {
			# print pre("Adding pref to RVH: $i over $j\n");
			my $complete = 1;
			for (my $i = 0; $i < $num_choices; $i++) {
			    for (my $j = 0; $j < $num_choices; $j++) {
				$rvh[$i][$j] = $temp[$i][$j];
				if ($complete && $i < $j && $temp[$i][$j] == 0 &&
				    $temp[$j][$i] == 0) {
# $i isn't related to $j yet... keep going
				    # print "No relation yet between $i and $j\n";
				    $complete = 0;
				}
			    }
			}
			if ($complete) { return; }
		    }
		}
	    }
	}
    }
}

# print_details($log, $n, $choices, $choice_index):
# Print out to RESULTS the details of the election algorithm, using the
# information in $log that was returned by rank_candidates.
sub print_details {
    (my $log) = @_;
    print main::RESULTS $log;
}

1;
