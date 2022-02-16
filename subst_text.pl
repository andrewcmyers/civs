#!/usr/bin/perl

sub Usage {
    print STDERR "Usage: subst_lang <translation_file> <language_code> <source_file> <dest_file>\n";
    exit 1;
}

sub Error {
    print STDERR (join ' ', @_), "\n";
    exit 1;
}

if ($#ARGV != 3) {
    &Usage;
}

my ($translation_file, $language_code, $source_file, $dest_file) = @ARGV;

undef $/;

open(TRANSLATIONS, $translation_file) || &Error("Could not open file: $translation_file");
binmode TRANSLATIONS, ':utf8';
my $trans_data = <TRANSLATIONS>;
close(TRANSLATIONS);

sub ParseKey {
    my ($input, $pos) = @_;
    my ($skip, $key) = substr($input, $pos) =~ m/\A(\s*([a-zA-Z][a-zA-Z_0-9]*))/;
    return unless $key;
    # print STDERR "  key at $pos: $key\n";
    $pos += length $skip;
    # print STDERR "Substr: ", substr($input, $pos), "\n";
    my ($skip2, $sep) = (substr($input, $pos) =~ /^( *(\{|:))/);
    # print STDERR "  sep: $sep\n";
    if (!$sep) {
        print STDERR "At key $key, expected : or { at position $pos: ", substr($input, $pos, 10), "...\n";
        return;
    }
    $pos += length $skip2;
    if ($sep eq '{') {
        my ($skip3) = (substr($input, $pos) =~ /(\s*\n)/);
        $pos += length $skip3;
    }
    # print STDERR "  next pos: $pos\n";
    return ($key, $sep, $pos);
}

sub ParseField {
    my ($input, $pos) = @_;
    #print STDERR "calling ParseKey\n";
    (my $key, $sep, $pos) = &ParseKey($input, $pos);
    return unless $key;
    #print STDERR "back from ParseKey\n";
    if ($sep eq ':') {
        my ($skip, $value) = substr($input, $pos) =~ /^(\s*(.*))\n/;
        # print "  single-line value: $key -> $value\n";
        return ($key, $value, $pos + length $skip);
    } else {
        my $n = length $input;
        my $pos2 = $pos;
        my $terminator;
        while ($pos2 < $n) {
            ($terminator) = substr($input, $pos2) =~ /\A(\n\s*\}\s*\n)/;
            last if $terminator;
            $pos2++;
        }
        my $value = substr($input, $pos, $pos2 - $pos);
        $pos2 += length $terminator;
        # print STDERR "long field: $key -> $value\n";
        return ($key, $value, $pos2);
    }
}

sub SkipComments {
    my ($input, $pos) = @_;
    while (1) {
        my ($skip) = substr($input, $pos) =~ /\A(\s*#.*\n)/;
        my $n = length $skip || 0;
        return $pos unless $n;
        $pos += $n
    }
    return $pos;
}

sub ParseEntry {
    my ($input, $pos) = @_;
    # print STDERR "looking for entry at $pos : ", substr($input, $pos, 10), "...\n";
    $pos = &SkipComments($input, $pos);
    (my $key, $sep, $pos) = &ParseKey($input, $pos);
    # print "Entry name: $key\n";
    return unless $key;
    my %fields;
    while (1) {
        (my $field, my $value, my $npos) = &ParseField($input, $pos);
        last unless ($field);
        $pos = $npos;
        # print STDERR "read field  $field, now at pos: $pos:", substr($input, $pos, 10), "...\n";
        $fields{$field} = $value;
    }
    my ($skip) = substr($input,$pos) =~ /^(\s*\}\s*\n)/;
    if (!$skip) {
       print STDERR "Expected } at position $pos: ", substr($input,
       $pos, 10), "\n";
    }
     # print STDERR "Done with entry: $key. Now at: ", substr($input, $pos + length skip, 10), "...\n";
    return ($key, \%fields, $pos + length($skip));
}

sub ParseTranslations {
    my ($input) = @_;
    my $pos = 0;
    my @result;
    my %translations;
    while (1) {
        (my $key, my $fields, my $npos) = &ParseEntry($input, $pos);
        last unless $key;
        $pos = $npos;
        my $translation = $fields->{$language_code} || $fields->{'en'} || 'unknown';
        $translations{$key} = $translation;
    }
    if ($pos < length $input) {
        print STDERR "Unexpected input at $pos: ", substr($input, pos, 15), "...\n";
    }
    return \%translations;
}

my %translations = %{&ParseTranslations($trans_data, $language_code)};

open(SOURCE, $source_file) || &Error("Can't open $source_file $source_file");
binmode SOURCE, ':utf8';

my $source = <SOURCE>;
close(SOURCE);

foreach my $name (keys %translations) {
    my $text = $translations{$name};
    # print STDERR "Replacing \@$name\@ with $text\n";
    $source =~ s[\@$name\@][$text]g;
}

open(DEST, ">$dest_file") || Error "Could not open $dest_file for writing";
binmode DEST, ':utf8';
print DEST $source;
close(DEST);
