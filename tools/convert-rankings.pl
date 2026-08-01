#!/usr/bin/env perl
use strict 'refs';
use warnings;
use Text::CSV;
use Text::CSV::Encoded;
use File::Basename;
use Scalar::Util qw(looks_like_number);

sub usage {
    my $base = &basename($0);
    print STDERR "Usage: $base <ranking.csv>\n\n";
    print STDERR "  Converts ballots in ordering format into CIVS format.\n";
    print STDERR "  For example, a file containing:\n\n";
    print STDERR "a,b,c,d\n";
    print STDERR "c,a,b,e\n";
    print STDERR "a,c,b,d\n";
    print STDERR "\n  produces output as follows:\n";
    print STDERR '
### list of choices ###
a
b
c
d
e
### ballots ###
1,2,3,4,-
2,3,1,-,4
1,3,2,4,-', "\n";

    exit 1;
}

my $nl = "\r\n";
my $csv = Text::CSV::Encoded->new({ encoding_in => "UTF-8",
                                    encoding_out => "UTF-8" });

# The sources that must be present in each output row
my %req_sources;

# merge rows with duplicate keys in the same file?
my $merge_dups = 0;

# report source files?
my $report_sources = 0;

sub TrimSuffix {
    my $result = $_[0];
    $result =~ s/\.csv$//;
    return $result;
}

while ($#ARGV >= 0 && $ARGV[0] =~ /^-/) {
    my $opt = shift @ARGV;
    print STDERR "Unknown option $opt.\n";
    usage()
}

my @req_sources = keys %req_sources;
# print STDERR "Requiring keys to be in these files: ", (join ', ', @req_sources), "\n";
my $nreq_sources = 1 + $#req_sources;

# remove leading and trailing whitespace and commas and
# collapse multiple whitespace into one.
sub clean {
    my $x = $_[0];
    chomp $x;
    $x =~ s/\s*$//g;
    $x =~ s/\s\s+$/ /g;
    $x =~ s/^\s*//g;
    $x =~ s/,*$//g;
    $x =~ s/^,*//g;
    return $x;
}

if ($#ARGV < 0) {
    usage();
    exit(1);
}
my $file = $ARGV[0];
open my $fileh, '<', $file;

my %names;
my @orderings = ();
my $num_rows = 0;

while (1) {
    my $row = $csv->getline($fileh);
    if (!defined($row)) { last; }

    my @ordering = @{$row};
    # printf "%s\n", join ",", @{$row};

    foreach my $name (@ordering) {
        $name = &clean($name);
        $names{$name} = 1;
    }
    $orderings[$num_rows++] = $row;
}

# print "number of rows: $num_rows\n";

my @name_list = sort {
    if (looks_like_number($a) && looks_like_number($b)) { return $a <=> $b }
    if (looks_like_number($a)) { return -1 }
    if (looks_like_number($b)) { return 1 }
    return $a cmp $b
} (keys %names);
my $num_names = $#name_list + 1;

# print "number of names: $num_names\n";
print "### list of choices ###\n";
foreach my $name (@name_list) {
    print "$name\n";
}

print "### ballots ###\n";
for (my $i = 0; $i < $num_rows; $i++) {
    my @ordering = @{$orderings[$i]};
    my $first = 1;
    foreach my $name (@name_list) {
        my $rank = "-";
        print "," unless $first;
        $first = 0;
        for ($j = 0; $j <= $#ordering; $j++) {
            if ($ordering[$j] eq $name) {
                $rank = $j + 1;
                last;
            }
        }
        print $rank;
    }
    print "\n";
}
