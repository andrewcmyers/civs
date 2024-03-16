package algorithms;

use strict;
use warnings;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(&fisher_yates_shuffle &unique_elements);
}

# From the Perl Cookbook, p. 121
# Generate a random permutation of @array in place.
sub fisher_yates_shuffle {
    my $array = shift;
    my $i;
    return if $#{$array} < 1;
    for ($i = @$array; --$i; ) {
        my $j = int rand ($i+1);
        next if $i == $j;
        @$array[$i,$j] = @$array[$j,$i];
    }
}

# From the Perl Cookbook, p. 102
# Return the unique elements from a list.
sub unique_elements {
    my %seen = ();
    my @uniq = ();
    foreach my $item (@_) {
        push(@uniq, $item) unless $seen{$item}++;
    }
    return @uniq;
}

1;
