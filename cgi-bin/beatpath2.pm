package beatpath2;

use strict;
use warnings;
use CGI qw(:standard);
use languages;

# A package for computing the Schulze method using both winning and losing
# votes (losing votes are purely secondary in the ordering).
#
# Definitions:
# The strength of a direct beat by choice A over choice B
# is a pair (W,L) where W>L and W is the number of ballots that
# rank A over B, and L is the number of ballots that rank B
# over A.
#
# Direct beats are totally ordered, with losing votes mattering
# only if winning votes are tied:
#   (W1,L1) > (W2,L2) iff (W1 > W2) or (W1 = W2 and L1 < L2)
#
# Therefore:
#
# max((W1,L1), (W2,L2)) = case  W1 > W2  ->  (W1, L1)
#                               W2 > W1  ->  (W2, L2)
#                               W1 = W2  ->  (W1, min(L1, L2))
# min((W1,L1), (W2,L2)) = case  W1 > W2  ->  (W2, L2)
#                               W2 > W1  ->  (W1, L1)
#                               W1 = W2  ->  (W1, max(L1, L2))
#
# The strength of a path (beatpath) is the min of the
# strengths of all the links along the path. To compare two
# choices, we look at the max of all the beatpaths between
# them.  If the max of the beatpaths from A to B is stronger
# than the max of all the beatpaths from B to A, then A is
# ranked above B.


# initial_matrix($m,$n): Return a matrix which is the
# initial starting point for the Floyd-Warshall algorithm.
# Input m is a reference to an n-by-n matrix.  For any given
# pair of elements ij and ji in m, at most one is
# initialized to something other than (0,0): the one that
# contains a larger value in m. That element is initialized
# to a reference to a pair containing the larger and the
# smaller of the two values.  Thus, diagonal elements are
# initialized to (0,0); if m_ij=m_ji, both are initialized
# to (0,0).
#
sub initial_matrix {
  my ($m, $n) = @_;
  my @r = ();
  for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
	my ($x, $y) = ($m->[$i][$j], $m->[$j][$i]);
	if ($x == $y) {
	    $r[$i][$j] = $r[$j][$i] = [(0,0)];
	} elsif ($x > $y) {
	    $r[$i][$j] = [($x,$y)];
	    $r[$j][$i] = [(0,0)];
	} else {
	    $r[$j][$i] = [($y,$x)];
	    $r[$i][$j] = [(0,0)];
	}
    }
  }
  return [@r];
}

# Expects references to arrays (W1,L1) and (W2,L2). Returns
# a new reference to such an array.
sub max {
    my ($xr, $yr) = @_;
    if (&compare_beats($xr, $yr) > 0) { return $xr; }
    else { return $yr; }
}

# Expects references to arrays (W1,L1) and (W2,L2). Returns
# a new reference to such an array.
sub min {
    my ($xr, $yr) = @_;
    if (&compare_beats($xr, $yr) > 0) { return $yr; }
    else { return $xr; }
}

# compare_beats(b1, b2) Compare two direct beats b1=[(W1,L1)] and
# b2 = [(W2,L2)].
sub compare_beats {
    my ($b1, $b2) = @_;
    if ($b1->[0] > $b2->[0]) { return 1; }
    elsif ($b1->[0] < $b2->[0]) { return -1; }
    elsif ($b1->[1] < $b2->[1]) { return 1; }
    elsif ($b1->[1] > $b2->[1]) { return -1; }
    else { return 0; }
}

# transitive_closure($m,$n): Compute the transitive
# (beatpath) closure of the square matrix referenced by $m.
# Result is destructively returned in $m itself.
#
# Requires: $n is the size of the matrix, and m is
# initialized as by initial_matrix.
#
# Implementation: Computes the transitive closure with ratings, using
#   the Floyd-Warshall algorithm, but with min = max, + = min.
#   This gives the necessary commutative semiring. Run time is O(n^3).
#   A classic of dynamic programming.

sub transitive_closure {
  my ($m,$n) = @_;
  for (my $k = 0; $k < $n; $k++) {
    main::ReportProgress(($k+1.0)/($n+1.0));
    for (my $i = 0; $i < $n; $i++) {
      for (my $j = 0; $j < $n; $j++) {
# Consider going from i to j via k, comparing to existing path.
	$m->[$i][$j] = &max($m->[$i][$j],
	                    &min($m->[$i][$k], $m->[$k][$j]));
      }
    }
  }
}

# winners($m, $n):
# Return the winner or winners in a reference to @winner, according to
# the transitive beatpath closure in @matrix. These
# are the choices that are unbeaten. Choices whose
# corresponding entry in @{$ignore} is 1 are ignored, others
# are considered both as possible winners and as beaters.
sub winners {
  my ($m, $n, $ignore) = @_;
  my @winner = ();
  for (my $i = 0; $i < $n; $i++) {
    if (!$ignore->[$i]) {
      my $won = 1;
      for (my $j = 0; $j < $n; $j++) {
	if (!$ignore->[$j]) {
	  if (&compare_beats($m->[$j][$i], $m->[$i][$j]) > 0) {
	    $won = 0;
	    last;
	  }
	}
      }
      if ($won) {
	push @winner, $i
      }
    }
  }
  [@winner]
}

# rank_candidates($prefs, $n, $ballots, $choices):
# Rank the $n choices using the raw information in $prefs,
# according to the beatpath winner criterion. Return a
# list containing a reference to @result -- where $result[0] is an array
# containing the highest ranked choices and so on, and a log
# of work done.
# 
# See runoff.pm for a more detailed spec.
#
# Note: $ballots is not used by this ranking algorithm.
#
sub rank_candidates {
  my ($n, $prefs, $ballots, $choices) = @_;
  my $beatpaths = &initial_matrix($prefs, $n);
  my $ignore = [()];
  &transitive_closure($beatpaths, $n);

  my $num_ranked = 0;
  my @result = ();
  while ($num_ranked < $n) {
    my $winner_list = &winners($beatpaths, $n, $ignore);
    push @result, $winner_list;
    foreach my $j (@{$winner_list}) {
	$ignore->[$j] = 1;
	$num_ranked++;
    }
  }
  return ([@result], $beatpaths);
}

my $cr = "\n";

sub Print {
    no warnings 'once';
    print main::RESULTS @_;
}

sub print_details {
    my ($beatpaths, $n, $choices, $choice_index) = @_;

    my $m = $beatpaths;
    my @choices = @{$choices};
    my @choice_index = @{$choice_index};

    Print p($tx->beatpath_matrix_explanation), $cr;

    Print '<table class="matrix">'.$cr;
    Print '<tr><td>&nbsp;</td><td>&nbsp;</td>';
    for (my $jj = 0; $jj < $n; $jj++) {
		my $j1 = $jj + 1;
		Print '<th width="20px">'.$j1.'.</th>';
    }
    Print '</tr>'.$cr;
    for (my $jj = 0; $jj < $n; $jj++) {
	my $j = $choice_index[$jj];
	my $j1 = $jj + 1;
	Print '<tr>';
	Print '<th align="left">', $j1, '.&nbsp;', $choices[$j], '</th>', $cr;
	Print '<td width="40px">&nbsp;</td>', $cr;
	for (my $kk = 0; $kk < $n; $kk++) {
	    my $k = $choice_index[$kk];
	if ($j == $k) {
		Print '<td class="count">-</td>';
	    } else {
		my $w = $m->[$j][$k];
		my $wlabel = "$w->[0]<small>&ndash;$w->[1]</small>";
		my $wlabelt = "$w->[0]-$w->[1]";
		if ($w->[0] == 0 && $w->[1] == 0) { $wlabelt = $tx->no_pref; }
		my $l = $m->[$k][$j];
		my $llabel = "$l->[0]<small>&ndash;$l->[1]</small>";
		my $llabelt = "$l->[0]-$l->[1]";
		if ($l->[0] == 0 && $l->[1] == 0) { $llabelt = $tx->no_pref; }
		my $comparison = &compare_beats($w, $l);
		if ($comparison > 0) {
		    Print "<td class=\"win\" title=\"$wlabelt vs. $llabelt\">";
		} elsif ($comparison == 0) {
		    Print "<td class=\"tie\" title=\"$wlabelt vs. $llabelt\">";
		} else {
		    Print "<td class=\"lose\" title=\"$wlabelt vs. $llabelt\">";
		}
		if ($w->[0] == 0) {
		    Print '.';
		} else {
		    Print "$wlabel";
		}
		Print '</td>', $cr;
	    }
	}
	Print '</tr>', $cr;
    }
    Print '</table>', $cr;
}


# a utility routine for debugging -- not used
sub print_matrix {
    my ($m, $n) = @_;
    for (my $i = 0; $i < $n; $i++) {
      for (my $j = 0; $j < $n; $j++) {
	my ($x, $y) = @{$m->[$i][$j]};
	print "$x/$y ";
      }
      print "\n";
    }
}

1; # success!
