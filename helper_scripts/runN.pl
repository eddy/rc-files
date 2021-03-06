#! /usr/bin/perl

# runN -- run a command on each of several arguments
# Copyright 2007 Mark Jason Dominus <mjd@plover.com>
# Modified by Aaron Crane; see http://aaroncrane.co.uk/2008/07/runN/
#
# To use this file, save it as "runN" in a directory in your $PATH.
# You may need to install List::MoreUtils first: sudo cpan -i List::MoreUtils

use strict;
use warnings;

BEGIN {
    use FindBin;
    use lib "$FindBin::Bin/lib";
}

use Getopt::Std qw<getopts>;
use List::MoreUtils qw<before any>;

sub usage {
    warn <<'EOF';
Usage: runN [OPTION]... COMMAND [ARGS... --] ITEMS...

Run COMMAND on each of the ITEMS.  If any ARGS are supplied, they will be
used as initial arguments to each invocation of the COMMAND.

Options:

  -v   Verbose: issue a message when running a command
  -j JOBS
       Run this many jobs in parallel (default: 1)

EOF
    exit 1;
}

my %opt = (j => 1);
getopts('j:v', \%opt) or usage();
usage() if !@ARGV;

my @command = shift @ARGV;
if (any { $_ eq '--' } @ARGV) {
    push @command, before { $_ eq '--' } @ARGV;
    splice @ARGV, 0, @command;
}

my %pid;
my $exit_status = 0;

for my $arg (@ARGV) {
    wait_for_child() while keys %pid >= $opt{j};
    $pid{ spawn(@command, $arg) } = 1;
}

1 while wait_for_child();
exit $exit_status;

sub wait_for_child {
    my $child = wait;
    $exit_status = 1 if $? != 0;
    return if $child < 0;
    delete $pid{$child};
    return 1;
}

sub spawn {
    my ($command, @args) = @_;
    warn "Execute: $command @args\n" if $opt{v};
    my $pid = fork;
    die "can't fork $command: $!\n" if !defined $pid;
    return $pid if $pid;
    exec { $command } $command, @args
        or die "can't exec $command: $!\n";
}
