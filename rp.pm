package rp;

use CGI qw(:standard);
use strict;

# Note: MAM would pick a random ballot and use it to resolve ties in
# order_pairs. Here we don't try to achieve a total
# ordering, but instead group identical-strength pairs into
# "bunches".
sub order_pairs {
	my @pair_a = @{$a};
	my @pair_b = @{$b};
	if ($pair_a[2] != $pair_b[2]) {
		return $pair_b[2] <=> $pair_a[2];
	} else {
		return $pair_a[3] <=> $pair_b[3];
	}
}

# rank_candidates(mref, num_choices) uses a ranked-pairs
# algorithm to ranks the "num_choices" choices
# according to the preference matrix in "mref". It returns
# a list ([@result], [@choice_index], $denied_any, $denied_report)
# where "result" is a list of lists ranking all the choices,
# "choice_index" is a permutation of the choices consistent
# with "result", "denied_any" reports whether any
# preferences had to be denied to construct a ranking, and
# denied_report is HTML text explaining which preferences
# were denied and why.
sub rank_candidates {
    (my $mref, my $num_choices) = @_;
    my @matrix = @{$mref};
    my @choice_index, my @result;
    my $denied_any = 0;
    my $denied_report = '';

    my @pairs = ();
    my @affirmed, my @committed, my @current, my @saved_current;
    for (my $j = 0; $j < $num_choices; $j++) {
	for (my $k = 0; $k < $num_choices; $k++) {
	    $committed[$j][$k] = 0;
	    $affirmed[$j][$k] = 0;
	    if ($matrix[$j][$k] > $matrix[$k][$j]) {
		push @pairs, [($j, $k, $matrix[$j][$k], $matrix[$k][$j])];
	    }
	}
    }
    @pairs = sort order_pairs @pairs;

    my $prev_win = 0;    # The strength of the previously considered winner
    my $prev_lose = 0;   # The strength of the previously considered loser
    my $bunch_index = 0; # Which of several identical-strength pairs this is.
                         # Typically zero.
#
# XXX Should copy 2-D arrays with $a[$i] = [@{$a[$i]}]
#
    foreach my $pair_ref (@pairs) {
	my @pair = @{$pair_ref};
	my $winner = $pair[0];
	my $loser = $pair[1];
	my $wname = $choices[$winner];
	my $lname = $choices[$loser];
	my $winvotes = $pair[2];
	my $losevotes = $pair[3];
	# print pre("Considering the $winvotes-$losevotes pref for $wname over $lname");
	if ($winvotes != $prev_win || $losevotes != $prev_lose) {
# new bunch: commit the affirmed prefs from the previous bunch
	    for (my $j = 0; $j < $num_choices; $j++) {
		for (my $k = 0; $k < $num_choices; $k++) {
		    $committed[$j][$k] = $affirmed[$j][$k];
		}
	    }
	    $prev_win = $pair[2];
	    $prev_lose = $pair[3];
	    $bunch_index = 0;
	} else {
	    $bunch_index++;
	}

	for (my $j = 0; $j < $num_choices; $j++) {
	    for (my $k = 0; $k < $num_choices; $k++) {
		$current[$j][$k] = $affirmed[$j][$k];
	    }
	}
# we take a preference if it doesn't create a new cycle when
# considered in combination with all strictly stronger

	sub TransitiveClosure {
# TransitiveClosure(m, winner, loser) adds the preference
# for winner over loser to the matrix and computes the
# transitive closure. If this creates any new cycles,
# returns 1 else 0.
	    my $mref = $_[0];
	    my $winner = $_[1];
	    my $loser = $_[2];
	    my $cycle = 0;
	    my @worklist = ([($winner, $loser)]);
	    $mref->[$winner][$loser] = 1;
	    while ($#worklist >= 0) {
		my $pr = shift @worklist;
		my $winner = $pr->[0];
		my $loser = $pr->[1];
		if ($mref->[$winner][$loser]) { next; }
		$mref->[$winner][$loser] = 1;
		if ($mref->[$loser][$winner]) { $cycle = 1; }
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

	my $cycle = TransitiveClosure [@current], $winner, $loser;

	if ($cycle && $bunch_index != 0) {
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
	    $cycle = TransitiveClosure [@temp], $winner, $loser;
	}
	if (!$cycle) {
	    for (my $j = 0; $j < $num_choices; $j++) {
		for (my $k = 0; $k < $num_choices; $k++) {
		    $affirmed[$j][$k] = $current[$j][$k];
		}
	    }
	} else {
	    if (!$denied_any) {
		denied_report .=
		    p('Some voter preferences were ignored because they 
		      conflict with other, stronger preferences:').$cr.'<ul>';
		$denied_any = 1;
	    }
	    denied_report .=
		li("The $pair[2]&ndash;$pair[3] preference for $wname 
				over $lname").$cr;
	}
	STDOUT->flush();
    }
    if ($denied_any) { denied_report .= '</ul>'; }

    my $num_ranked = 0;
    my @ignore, my @ordering, my @rp_choice_index;
    while ($num_ranked < $num_choices) {
	my @winner = ();
	for (my $i = 0; $i < $num_choices; $i++) {
	    if (!$ignore[$i]) {
		my $won = 1;
		for (my $j = 0; $j < $num_choices; $j++) {
		    if (!$ignore[$j]) {
			if ($affirmed[$j][$i] > $affirmed[$i][$j]) {
			    $won = 0;
			    last;
			}
		    }
		}
		if ($won) {
		    push @winner, $i;
		    $rp_choice_index[$num_ranked++] = $i;
		}
	    }
	}
	push @result, [@winner];
	foreach my $j (@winner) { $ignore[$j] = 1; }
    }

    return ([@result], [@rp_choice_index], $denied_any, $denied_report);
}
