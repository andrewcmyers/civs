package beatpath;

# Definitions:
# The strength of a direct beat is the maximum
# of the number of votes that rank one candidate
# above the other.

# The strength of a path (beatpath) is the
# minimum of the strengths of all the links
# along the path.

# A clean matrix is one in which given elements
# symmetrically located around the diagonal, at
# most one is nonzero.

######

# clean_matrix: Clean the matrix @m by removing
# the minimal element of every symmetric pair
# of elements, setting it to zero.
sub clean_matrix {
  for (local $i = 0; $i < $n; $i++) {
    for (local $j = 0; $j < $n; $j++) {
	if ($matrix[$i][$j] == $matrix[$j][$i]) {
	    $matrix[$i][$j] = $matrix[$j][$i] = 0;
	} elsif ($matrix[$i][$j] < $matrix[$j][$i]) {
	    $matrix[$i][$j] = 0;
	} else {
	    $matrix[$j][$i] = 0;
	}
    }
  }
}

# transitive_closure: Compute the transitive (beatpath) closure of
# the square matrix @matrix and place the result in @out.  The entry
# $out[$i][$j] is the strength of the strongest beatpath from $i to $j,
# or 0 if there is none.
# Requires: $n is the size of the matrix, and @matrix is
# already clean.
# Implementation: computes the transitive closure with weights, using
#   the Floyd-Warshall algorithm, but with min = max, + = min. Runtime
#   is O(n^3).

sub min {
    if ($_[0] < $_[1]) {
	return $_[0];
    } else {
	return $_[1];
    }
}

sub transitive_closure {
  for (local $k = 0; $k < $n; $k++) {
    for (local $i = 0; $i < $n; $i++) {
      for (local $j = 0; $j < $n; $j++) {
# consider going from i to j via k
	local $s = min($matrix[$i][$k], $matrix[$k][$j]);
	if ($s > $matrix[$i][$j]) {
	    $matrix[$i][$j] = $s;
	}
# m_ij = max(m_ij, min(s1,s2))
      }
    }
  }
}
 
# Return the winner or winners in @winners, according to
# the transitive beatpath closure of @matrix. These
# are the candidates that are unbeaten. Candidates whose
# corresponding entry in @ignore is 1 are ignored, others
# are considered both as possible winners and as beaters.
sub winners {
  @winner = ();
  for (local $i = 0; $i < $n; $i++) {
    if (!$ignore[$i]) {
      local $won = 1;
      for (local $j = 0; $j < $n; $j++) {
	if (!$ignore[$j]) {
	  if ($matrix[$j][$i] > $matrix[$i][$j]) {
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
}

# Return the loser or losers in @losers, according to
# the transitive beatpath closure of @matrix. These
# are the candidates that don't beat anyone. Candidates whose
# corresponding entry in @ignore is 1 are ignored, others
# are considered both as possible losers and as beaters.
sub losers {
  @loser = ();
  for (local $i = 0; $i < $n; $i++) {
    if (!$ignore[$i]) {
      local $won_any = 0;
      for (local $j = 0; $j < $n; $j++) {
	if (!$ignore[$j]) {
	  if ($matrix[$i][$j] > $matrix[$j][$i]) {
	    $won_any = 1;
	    last;
	  }
	}
      }
      if (!$won_any) {
	push @loser, $i
      }
    }
  }
}


# Rank the $n candidates using the raw
# information in $matrix, according to
# the beatpath winner criterion. Place
# the result in @result, where $result[0]
# is an array containing the highest ranked
# candidates and so on.
sub rank_candidates {
  local @save_matrix = @matrix;
  clean_matrix();
  transitive_closure();

  local $num_ranked = 0;
  losers();
  foreach $j (@loser) { $ignore[$j] = 1; }
  $num_ranked += $#loser + 1;
  @result = ();
  while ($num_ranked < $n) {
    winners();
    push @result, [@winner];
    foreach $j (@winner) { $ignore[$j] = 1; }
    $num_ranked += $#winner + 1;
  }
  push @result, [@loser];
  @closure_matrix = @matrix;
  @matrix = @save_matrix;
}

# a utility routine for debugging -- not used
sub print_matrix {
    for ($i = 0; $i < $n; $i++) {
      for ($j = 0; $j < $n; $j++) {
	print "$matrix[$i][$j] ";
      }
      print "\n";
    }
}

1; # ok!
