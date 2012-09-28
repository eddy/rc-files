#!/usr/bin/env perl

use strict;
use warnings;
use autodie ':all';
use Regexp::Common;

my $module = shift or die "usage: $0 pm_file";

my $key_found = qr/
    (?: \$self | \$_\[0\] | shift )  # $self or $_[0] or shift
    \s* ->                         # ->
    \s* {                          # {
    \s* ($RE{quoted}|\w*)          # $hash_key
    \s* }                          # }
/x;

open my $fh, '<', $module;

my %count_for;
while (<$fh>) {
    while (/$key_found/g) {
        my $key = $1;
        $key =~ s/^["']|['"]$//g;    # try and strip the quotes

        no warnings 'uninitialized';
        $count_for{$key}{count}++;
        $count_for{$key}{line} = $.;
    }
}

foreach my $key ( sort keys %count_for ) {
    next if $count_for{$key}{count} > 1;
    print "Possibly unused key '$key' at line $count_for{$key}{line}\n";
}


