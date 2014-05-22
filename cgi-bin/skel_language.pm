package language_name; # replace with the name of your language, e.g. spanish.

our $VERSION = 1.0;

use lib '@CGIBINDIR@';

use base_language;
our @ISA = ('base_language'); # go to AmE module for missing methods

# The language identifier, eg en-US for American English or es-ES for Spanish ala Spain.
sub lang { 'xx-XX' }

sub init {
    my $self = {}; 
    bless $self; 
    return $self; 
}

sub style_file {
    'style.css'; # probably what is wanted except for right-to-left languages
}

# Reimplement additional functions from base_language.pm here. Any unimplemented
# functions will use the base_language implementation (American English)

sub Condorcet_Internet_Voting_Service {
    'Condorcet Internet Voting Service';
}
sub Condorcet_Internet_Voting_Service_email_hdr { # Note: charset may be limited 
    'Condorcet Internet Voting Service';
}
