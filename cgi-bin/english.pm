package english;

use base_language;
use utf8;

our $VERSION = 1.20;
our @ISA = ('base_language'); # go to base_language module for missing methods
sub lang { 'en-US' }

sub init {
    my $self = {};
    bless $self;
    return $self;
}

sub ordinal_of {
    my $n = $_[1];
    if ($n >= 4 && $n < 20) {
	return $n.'th'
    } elsif ($n % 10 == 1) {
	return $n.'st'
    } elsif ($n % 10 == 2) {
	return $n.'nd'
    } elsif ($n % 10 == 3) {
	return $n.'rd'
    } else {
	return $n.'th'
    }
}

1; # package succeeded!
