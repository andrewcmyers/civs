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
  for (my $i = 0; $i < $n; $i++) {
    for (my $j = 0; $j < $n; $j++) {
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

sub transitive_closure {
  my @save = @matrix;

  # compute transitive closure with weights

  $changed = 1;
  while ($changed) {
    $changed = 0;
    for ($i = 0; $i < $n; $i++) {
      for ($j = 0; $j < $n; $j++) {
	for ($k = 0; $k < $n; $k++) {
# consider going from i to k via j
	  my $s1 = $matrix[$i][$j];
	  my $s2 = $matrix[$j][$k];
	  my $s = $s1;
	  if ($s > $s2) { $s = $s2; }
# note: if one of s1 or s2 is 0, s will be too -- so can ignore this case
	  if ($s > $matrix[$i][$k]) {
	    $matrix[$i][$k] = $s;
	    $changed = 1;
	  }
	}
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
  for (my $i = 0; $i < $n; $i++) {
    if (!$ignore[$i]) {
      my $won = 1;
      for (my $j = 0; $j < $n; $j++) {
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

# Rank the $n candidates using the raw
# information in $matrix, according to
# the beatpath winner criterion. Place
# the result in @result, where $result[0]
# is an array containing the highest ranked
# candidates and so on.
sub rank_candidates {
  my @save_matrix = @matrix;
  clean_matrix();
  transitive_closure();

  local $num_ranked = 0;
  @result = ();
  while ($num_ranked < $n) {
    winners();
    push @result, [@winner];
    for (local $i = 0; $i <= $#winner; $i++) {
      $ignore[$winner[$i]] = 1;
    }
    $num_ranked += $#winner + 1;
  }
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
