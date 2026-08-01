use strict;
# use Text::WrapI8N qw(wrap $columns);

my $edit = 0;
my $outputfile;
my $new_trans;
my $new_language;

# Set up to output a new version of the translations file that
# incorporates an additional language.
sub EditTranslationFile {
    ($outputfile, $new_trans, $new_language) = @_;
}

sub ParseKey {
    my ($input, $pos) = @_;
    my ($skip, $key) = substr($input, $pos) =~ m/\A(\s*([a-zA-Z][a-zA-Z_0-9]*))/;
    if ($outputfile) {
        print $outputfile $skip;
    }
    return unless $key;
    $pos += length $skip;
    my ($skip2, $sep) = (substr($input, $pos) =~ /^( *(\{|:))/);
    if (!$sep) {
        print STDERR "At key $key, expected : or { at position $pos: ",
                     substr($input, $pos, 10), "...\n";
        return;
    }
    if ($outputfile) {
        print $outputfile $skip2;
    }
    $pos += length $skip2;
    if ($sep eq '{') {
        my ($skip3) = (substr($input, $pos) =~ /(\s*\n)/);
        $pos += length $skip3;
        if ($outputfile) {
            print $outputfile $skip3;
        }
    }
    return ($key, $sep, $pos, length($skip) - length($key));
}

sub ParseField {
    my ($input, $pos) = @_;
    #print STDERR "calling ParseKey\n";
    (my $key, my $sep, $pos, my $indent) = &ParseKey($input, $pos);
    return unless $key;
    #print STDERR "back from ParseKey\n";
    if ($sep eq ':') {
        my ($skip, $value) = substr($input, $pos) =~ /^(\s*(.*)\n)/;
        if ($outputfile) {
            print $outputfile $skip;
        }
        return ($key, $value, $pos + length $skip, $indent);
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
        if ($outputfile) {
            print $outputfile $value, $terminator;
        }
        return ($key, $value, $pos2, $indent);
    }
}

sub SkipComments {
    my ($input, $pos) = @_;
    while (1) {
        my ($skip) = substr($input, $pos) =~ /\A(\s*#.*\n)/;
        if ($outputfile) {
            print $outputfile $skip;
        }
        my $n = length $skip || 0;
        return $pos unless $n;
        $pos += $n
    }
    return $pos;
}

sub ParseEntry {
    my ($input, $pos) = @_;
    $pos = &SkipComments($input, $pos);
    my ($key, $sep, $pos, $indent) = &ParseKey($input, $pos);
    return unless $key;
    my %fields;
    my $indent;
    while (1) {
        (my $field, my $value, my $npos, my $indent1) = &ParseField($input, $pos);
        last unless ($field);
        $indent = $indent1;
        $pos = $npos;
        $fields{$field} = $value;
    }
    if ($outputfile && !defined($fields{$new_language})) {
        my %nt = %{$new_trans};
        my $value = $nt{$key};
        print $outputfile (" " x $indent), $new_language;
        if (length $value > 70) {
            # my $tab = " " x ($indent + 2);
            # $Text::Wrap::columns = 75;
            # $value = wrap('', $tab, $value);
        }
        if ($value =~ /\n/) {
            print $outputfile " {\n", (" " x ($indent + 1)), $value, "\n",
               (" " x $indent), "}\n";
        } else {
            print $outputfile ': ', $value, "\n";
        }
    }
    my ($skip) = substr($input,$pos) =~ /^(\s*\}\s*\n)/;
    if (!$skip) {
       print STDERR "Expected } at position $pos: ", substr($input,
       $pos, 10), "\n";
    } elsif ($outputfile) {
        print $outputfile $skip;
    }
    return ($key, \%fields, $pos + length($skip));
}

sub ParseTranslations {
    my ($input, $language_code) = @_;
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

1;
