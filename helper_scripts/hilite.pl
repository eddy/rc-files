#!/usr/bin/perl
# hilite.pl - perl code colorizer on an ANSI terminal (xterm / putty session)
# place this script in your path and make executable, e.g.
#   $ cp hilite.pl ~/bin/hilite
#   $ chmod 755 ~/bin/hilite
# then run it to colorize text output that contains perl, e.g.
#   $ svn diff /some/path/MyModule.pm | hilite
# and you get syntax colored text

use strict;
use warnings;
use utf8; 
use open ':utf8';

use Syntax::Highlight::Engine::Kate;
use Term::ANSIColor qw(:constants);
use IO::File;

my $hl = Syntax::Highlight::Engine::Kate->new(
    language => 'Perl',
    substitutions => {},
    format_table => {
        Alert => [RED, RESET],
        BaseN => [RED, RESET],
        BString => [YELLOW, RESET],
        Char => [YELLOW, RESET],
        Comment => [CYAN, RESET],
        DataType => [GREEN, RESET],
        DecVal => [RED, RESET],
        Error => [RED, RESET],
        Float => [RED, RESET],
        Function => [MAGENTA, RESET],
        IString => [MAGENTA, RESET],
        Keyword => [YELLOW, RESET],
        Normal => ["", ""],
        Operator => [GREEN, RESET],
        Others => [MAGENTA, RESET],
        RegionMarker => [ON_GREEN, RESET],
        Reserved => [BLACK ON_BLUE, RESET],
        String => [MAGENTA, RESET],
        Variable => [GREEN, RESET],
        Warning => [RED, RESET],
    },
);

my $fh;
my $file = shift @ARGV;
if ( !$file || $file eq '-' ) {
    binmode STDIN;
    $fh = \*STDIN;
}
else {
    $fh = IO::File->new($file)
        || die "Cannot open file: $file: $!";
}

while ( my $line = <$fh> ) {
    print $hl->highlightText($line);
};
