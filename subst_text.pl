#!/usr/bin/env perl

use strict;
use warnings;

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

binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

open(TRANSLATIONS, $translation_file) || &Error("Could not open file: $translation_file");
binmode TRANSLATIONS, ':utf8';
my $trans_data = <TRANSLATIONS>;
close(TRANSLATIONS);

sub ParseKey {
    my ($input, $pos) = @_;
    my ($skip, $key) = $input =~ m/\A(\s*([a-zA-Z][a-zA-Z_0-9]*))/;
    return unless $key;
    my $n = length $skip;
    $pos += $n; $input = substr($input, $n);
    my ($skip2, $sep) = $input =~ /^( *(\{|:))/;
    if (!$sep) {
        print STDERR "At key $key, expected : or { at position $pos: ", substr($input, $pos, 10), "...\n";
        return;
    }
    $n = length $skip2;
    $pos += $n; $input = substr($input, $n);
    if ($sep eq '{') {
        my ($skip3) = $input =~ /(\s*\n)/;
        $pos += length $skip3;
    }
    return ($key, $sep, $input, $pos);
}

sub ParseField {
    my ($input, $pos) = @_;
    #print STDERR "calling ParseKey\n";
    (my $key, my $sep, $input, $pos) = &ParseKey($input, $pos);
    return unless $key;
    if ($sep eq ':') {
        my ($skip, $value) = $input =~ /^(\s*(.*))\n/;
        my $k = length $skip;
        return ($key, $value, substr($input, $k), $pos + $k);
    } else {
        my $terminator;
        my $value;
        while ($input) {
            ($terminator) = $input =~ /\A(\n\s*\}\s*\n)/;
            last if $terminator;
            $value .= substr($input, 0, 1);
            $pos++; $input = substr($input, 1);
        }
        $value =~ s/\\\r?\n\s*//g;
        $value =~ s/\\ / /g;
        my $k = length $terminator;
        $pos += $k; $input = substr($input, $k);
        return ($key, $value, $input, $pos);
    }
}

sub SkipComments {
    my ($input, $pos) = @_;
    while (1) {
        my ($skip) = $input =~ /\A(\s*#.*\n)/;
        my $k = length $skip || 0;
        return ($input, $pos) unless $k;
        $pos += $k; $input = substr($input, $k);
    }
    return ($input, $pos);
}

sub ParseEntry {
    my ($input, $pos) = @_;
    ($input, $pos) = &SkipComments($input, $pos);
    (my $key, my $sep, $input, $pos) = &ParseKey($input, $pos);
    return unless $key;
    my %fields;
    while (1) {
        (my $field, my $value, my $ninput, my $npos) = &ParseField($input, $pos);
        last unless ($field);
        $pos = $npos;
        $input = $ninput;
        $fields{$field} = $value;
    }
    my ($skip) = $input =~ /^(\s*\}\s*\n)/;
    if (!$skip) {
       print STDERR "Expected } at position $pos: ", substr($input, 0, 10), "\n";
    }
    my $k = length $skip;
    return ($key, \%fields, substr($input, $k), $pos + $k)
}

sub ParseTranslations {
    my ($input) = @_;
    my $pos = 0;
    my @result;
    my %translations;
    while (1) {
        (my $key, my $fields, my $ninput, my $npos) = &ParseEntry($input, $pos);
        last unless $key;
        print STDERR "Parsed key $key\n";
        $input = $ninput;
        $pos = $npos;
        my $translation = $fields->{$language_code} || $fields->{'en'} || 'unknown';
        $translations{$key} = $translation;
    }
    if ($input) {
        print STDERR "Unexpected input at $pos: ", substr($input, 15), "...\n";
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
    $source =~ s[\@$name\@][$text]g;
}

open(DEST, ">$dest_file") || Error "Could not open $dest_file for writing";
binmode DEST, ':utf8';
print DEST $source;
close(DEST);
