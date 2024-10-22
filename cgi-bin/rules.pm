package rules;
use strict;
use warnings;

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw(%legal_module %algorithm_module);
}

# Map each completion rule name to the module that computes it.
our %algorithm_module = (beatpath_winner => 'beatpath', # obsolete
                        beatpath => 'beatpath2',
                        civs_ranked_pairs => 'rp',
		        mam => 'rp',
		        runoff => 'runoff',
                        minimax => 'minimax',
                        minimax_wv => 'minimax',
                        b2r => 'b2r'
                       );

# Map legal completion rule modules to 1.
our %legal_module = (beatpath2 => 1,
                    rp => 1,
		    runoff => 1,
                    minimax => 1,
                    b2r => 1);

1;
