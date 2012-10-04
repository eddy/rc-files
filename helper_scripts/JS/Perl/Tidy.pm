package JS::Perl::Tidy;
use Perl::Tidy qw();
use strict;
use warnings;

sub perltidy {
    return Perl::Tidy::perltidy( prefilter => \&prefilter, postfilter => \&postfilter, @_ );
}

sub prefilter {
    $_ = $_[0];

    # Turn method into sub
    s/^method (.*)/sub $1 \#__METHOD/gm;

    # Hide 'has' lines from perltidy
    s/^(has .*)/\# __NO_TIDY $1/gm;

    return $_;
}

sub postfilter {
    $_ = $_[0];

    # Remove hidden lines
    s/^\# __NO_TIDY //gm;

    # Turn sub back into method
    s/^sub (.*?)\s* \#__METHOD/method $1/gm;

    # Add empty parens
    s/^method(\s*\w+\s*)\{/method$1 \(\) \{/gm;

    # One arg, no spaces inside paren
    s/^method (\w+) \(\s*([\$\@\%]\w+)\s*\)/method $1 \($2\)/gm;

    # Space between method name and paren
    s/^method (\w+)\(/method $1 \(/gm;
    
    return $_;
}

 1;

