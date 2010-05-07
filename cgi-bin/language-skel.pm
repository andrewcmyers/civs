package the_language;
# change the_language to the name of the language, e.g., "german", "italian",
# etc.

use lib '@CGIBINDIR@';

use english;
our @ISA = ('english'); # go to AmE module for missing methods


sub lang { return 'en-US'; }
# replace en-US with appropriate ISO639 code or ISO639 + ISO3166 code.

sub init {
    my $self = {};
    bless $self;
    return $self;
}

# civs_common
sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service';
    # translate this string
}

# Now for all the work: continue with rest of subroutines from english.pm
