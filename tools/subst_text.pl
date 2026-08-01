#!/usr/bin/env perl

sub Usage {
    print STDERR "Usage: subst_text <translation_file> <language_code> <source_file> <dest_file>\n";
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
my $trans_data = <TRANSLATIONS>;
close(TRANSLATIONS);

sub ParseKey {
    my ($input, $pos) = @_;
    my ($skip, $key) = substr($input, $pos) =~ m/\A(\s*([a-zA-Z][a-zA-Z_0-9]*))/;
    return unless $key;
    $pos += length $skip;
    my ($skip2, $sep) = (substr($input, $pos) =~ /^( *(\{|:))/);
    if (!$sep) {
        print STDERR "At key $key, expected : or { at position $pos: ", substr($input, $pos, 10), "...\n";
        return;
    }
    $pos += length $skip2;
    if ($sep eq '{') {
        my ($skip3) = (substr($input, $pos) =~ /(\s*\n)/);
        $pos += length $skip3;
    }
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
        $value =~ s/\\\r?\n\s*//g;
        $value =~ s/\\ / /g;
        $pos2 += length $terminator;
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
    $pos = &SkipComments($input, $pos);
    (my $key, $sep, $pos) = &ParseKey($input, $pos);
    return unless $key;
    my %fields;
    while (1) {
        (my $field, my $value, my $npos) = &ParseField($input, $pos);
        last unless ($field);
        $pos = $npos;
        $fields{$field} = $value;
    }
    my ($skip) = substr($input,$pos) =~ /^(\s*\}\s*\n)/;
    if (!$skip) {
       print STDERR "Expected } at position $pos: ", substr($input,
       $pos, 10), "\n";
    }
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

my $source = <SOURCE>;
close(SOURCE);

foreach my $name (keys %translations) {
    my $text = $translations{$name};
    $source =~ s[\@$name\@][$text]g;
}

open(DEST, ">$dest_file") || Error "Could not open $dest_file for writing";
print DEST $source;
close(DEST);
