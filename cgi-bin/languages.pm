package languages;

use strict;
no strict 'refs';
use warnings;
use lib '@CGIBINDIR@';

BEGIN {
    use Exporter ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    $VERSION     = 1.00;
    @ISA         = qw(Exporter);
    @EXPORT      = qw($tx);
}

our $accept_language;
our $tx;
our $log;

# First column: name of package
# Second column: Language tags (forced to lower case)
#    See also http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
#    and RFC 5646 (http://tools.ietf.org/html/rfc5646)
# Third column: quality/priority. Multiplied by whatever the
#   user agent provides.
my @variants =
  (['english', 'en-us', 1.0],
   ['english', 'en', 1.0],
   ['english', 'en-ca', 0.95],
   ['english', 'en-gb', 0.90],
   ['english', 'en-au', 0.90],
   ['english', 'en-nz', 0.90],
   ['english', 'en-ng', 0.90],
   ['hungarian', 'hu-hu', 0.95],
   ['hungarian', 'hu', 0.95],
   ['italian', 'it', 0.95],
   ['italian', 'it-it', 0.95],
   ['french', 'fr', 0.95],
   ['french', 'fr-fr', 0.95],
   ['german', 'de', 0.95],
   ['german', 'de-de', 0.95],
   ['hebrew', 'he', 0.95],
   ['hebrew', 'he-il', 0.95],
   ['hindi', 'hi', 0.00],
   ['hindi', 'hi-in', 0.00],
   ['portuguese', 'pt', 0.90],
   ['portuguese', 'pt-pt', 0.90],
   ['portuguese', 'pt-br', 0.95],
   ['chinese', 'zh-cn', 0.95],
   ['chinese', 'zh', 0.90],
   ['chinese', 'zh-tw', 0.70],
   ['russian', 'ru', 0.60],
   ['russian', 'ru-ru', 0.60],
   ['spanish', 'es', 0.90],
   ['spanish', 'es-es', 0.95],
   ['thai', 'th', 0.95],
  );

# Result: &init() determines the current language preference using the
#         available languages and the HTTP Accept-Language header.
sub init {
    ($accept_language) = @_;
    chomp $accept_language;
    $accept_language = lc $accept_language;
    my @reqs = split /\s*,\s*/, $accept_language;
    my @choices, my @qualities;
    my $i;
    for ($i = 0; $i <= $#reqs; $i++) {
	my $lang, my $quality = 1.0;
	if ($reqs[$i] =~ /;/) {
	    ($lang, $quality) = ($reqs[$i] =~ m/^(\S+)\s*;\s*q\s*=\s*(.*)$/s);
	    $quality += 0.0;
	} else {
	    $lang = $reqs[$i];
	}
	push @choices, $lang;
	push @qualities, $quality;
    }
    my $language = 'english'; #default
    my $best = 0.0;

    for ($i = 0; $i <= $#variants; $i++) {
	my @row = @{$variants[$i]};
	for (my $j = 0; $j <= $#choices; $j++) {
	    if ($row[1] eq $choices[$j] &&
		$row[2] * $qualities[$j] > $best) {
		$best = $row[2] * $qualities[$j];
		$language = $row[0];
		$log .= "Choosing $language (score $best)\n";
	    }
	}
    }
    require "$language.pm";
    my $init = $language . "::init";
    $tx = &$init();
    return;
}

1;
