#!/usr/bin/perl

# $Id: sql.pl,v 1.12 2008/10/29 05:40:47 et6339 Exp et6339 $
# $Revision: 1.12 $
# $Date: 2008/10/29 05:40:47 $

use strict;
use warnings;

######################################################################
# Modules
#

use DBI;
use Sys::Hostname;
use Getopt::Long;
use Hash::Util qw(lock_keys);

BEGIN {
    use FindBin;
    use lib "$FindBin::Bin";
    use Text::Table;
}

######################################################################
# Command line options
#

# Parameter variables + defaults
my $user      = 'clink';
my $password  = 'clink07';
my $dbname    = hostname() =~ /vcmsp/ ? 'clink'
                                      : 'clinkt';
my $helpflag  = 0;
my $tableflag = 0;

GetOptions ( 'user=s'     => \$user,
             'password=s' => \$password,
             'dbname=s'   => \$dbname,
             'table'      => \$tableflag,
             'help'       => \$helpflag,
           ) or die usage();

if ( $helpflag ) { print usage() . "\n"; exit; }

######################################################################
# Database connection
#

my $dbh;
$dbh = DBI->connect("dbi:Oracle:${dbname}", $user, $password,
                    { RaiseError => 1, PrintError => 0, AutoCommit => 0 });

######################################################################
# Configuration and global variables
#

my @cmd_history   = (); # Command history
my $cmd_buffer    = q{}; # Start with empty buffer
my $history_file  = "$ENV{HOME}/.sqlbrad-history";

my $save_history = 0; # Flag determining if history is to be saved

######################################################################
# Main program
#

# Populate command history
_retrieve_history();

# Main loop
_print_help_line();
while (<>) {
  chomp;

  # React to special commands or append to command buffer
    uc($_) eq 'Q'     ? last
  : uc($_) eq 'TAB'   ? _handle_table_toggle($_)
  : uc($_) eq 'DNS'   ? _handle_history_toggle($_)
  : uc($_) eq 'S'     ? _handle_history_toggle($_)
  : uc($_) eq 'H'     ? _handle_history()
  : $_ =~ /^R(\d*)$/i ? _handle_repeat($1)
                      : _handle_append_cmd($_);
                
  # Execute if the buffered command is done
  if ( $cmd_buffer =~ /;$/ ) {
    _execute();
    _print_help_line();
  }
}

# Update command history
_store_history();

# Roll-back anything that hasn't been committed
$dbh->rollback();

# Disconnect from database
$dbh->disconnect();

######################################################################
# Subroutines
#

sub usage {
  return "$0 [--user=<username>] [--password=<password>] [--dbname=<dbname>]";
}

sub _print_help_line {
  print "\n"
      . ">>> Q : Quit ...                              [Logged in as ${user}\@${dbname}]\n"
      . ">>> DNS: Stop saving history ... S: Start saving history (Currently: "
      . ( $save_history ? "ON" : "OFF" )
      . ")\n"
      . ">>> TAB: Use nice table layout ... (Currently: "
      . ( $tableflag ? "ON" : "OFF" )
      . ")\n"
      . ">>> H: Show history ... Rn: Repeat history item n\n"
      ;
}

sub _handle_history_toggle {
  my ($command) = @_;

  if ( uc($command) eq 'DNS' ) {
    print "History saving is now turned OFF\n";
    $save_history = 0;
  }
  elsif ( uc($command) eq 'S' ) {
    print "History saving is now turned ON\n";
    $save_history = 1;
  }
}

sub _handle_history {
  $cmd_buffer = q{}; # Clear the command buffer

  print "History:\n";
  my $index = 0;
  print " [" . $index++ . "] $_\n" for @cmd_history;
}

sub _handle_repeat {
  my ($repeat_index) = @_;

  # Default is zero
  $repeat_index = 0 unless $repeat_index;

  if ( exists $cmd_history[$repeat_index] ) {
    $cmd_buffer = $cmd_history[$repeat_index] . ';';
    print "Repeat: $cmd_buffer\n";
  }
  else {
    print "REPEAT INDEX $repeat_index DOES NOT EXIST\n";
  }
}

sub _handle_append_cmd {
  # Strip pre/post whitespace
  $_ =~ s/^\s*//;
  $_ =~ s/\s*$//;

  # Append command buffer
  $cmd_buffer .= " $_";

  # Strip pre/post whitespace again
  $cmd_buffer =~ s/^\s*//;
  $cmd_buffer =~ s/\s*$//;
}

sub _handle_table_toggle {
  my ($command) = @_;

  if ( uc($command) eq 'TAB' ) {
      $tableflag = ( $tableflag == 0 ) ? 1 : 0;

      print "Table layout is now turned "
            . ( $tableflag == 0 ? "OFF" : "ON" )
            . "\n";
  }

  return;
}

sub _retrieve_history {
  if ( -f $history_file ) {
    open my $history_fh, "<", $history_file || die($!);
    @cmd_history = <$history_fh>;
    chomp($_) for @cmd_history;
    close $history_fh;
  }
}

sub _store_history {
  open my $history_fh, ">", $history_file || die($!);
  print $history_fh "$_\n" for @cmd_history;
  close $history_fh;
}

sub _execute {
  chop $cmd_buffer; # Remove the trailing ;
  my $sth;

  eval {
    $sth = $dbh->prepare($cmd_buffer);
    $sth->execute();
  };
  if ( $@ ) {
    warn $@;
    $cmd_buffer = q{}; # Clear the command buffer
    return;
  }

  my %table_content = ( 'title' => undef,
                        'body'  => undef,
                        'rows'  => 0,
                      );
  lock_keys(%table_content); # Avoid typo...
                      
  # Build our table...
  $table_content{'title'} = join( ' | ', @{$sth->{NAME}} );

  if ( $cmd_buffer =~ /^select/i ) {
      while ( my $row = $sth->fetchrow_arrayref() ) {
          my @null_to_string_row = map { defined $_ ? $_ : '[NULL]' } @{$row};
          my $null_to_string_row = join(' | ',     @null_to_string_row);
          
          $table_content{'body'} .= $null_to_string_row . "\n";
      }
  }

  # Number of rows affected...
  $table_content{'rows'} = $sth->rows();
  
  # Display the result...
  _display_result(\%table_content);
  
  # Store command in history (if history is being saved and it is different)
  if ( $save_history && $cmd_history[0] ne $cmd_buffer ) {
    unshift @cmd_history, $cmd_buffer; 
  }

  $cmd_buffer = q{}; # Clear the command buffer
}

sub _display_result {
    my ($table_ref) = @_;
    
    # empty line after the sql command...
    print "\n";
    
    # display rows if it's a select...
    if ( $cmd_buffer =~ /^select/i ) {
        if ($tableflag) {
            # generate Text::Table object...
            my @column_names  = split /(\|)/, $table_ref->{'title'};
            my $tb            = Text::Table->new( @column_names );
            
            if ( $table_ref->{'rows'} > 0 ) {
                foreach my $row ( split /\n/, $table_ref->{'body'} ) {
                    my @null_to_string_row  = split /(\|)/, $row;
                    $tb->load(\@null_to_string_row);
                }
            }

            my $row   = 1;
            my @lines = $tb->table;
            for my $line (@lines) {
                print $line;
                print '-'x$tb->width . "\n" if $row++ == 1;
            }
        }
        else {
            # normal print (not Table::Text)...
            print "$table_ref->{'title'}\n";
            print '-'x(length($table_ref->{'title'})) . "\n";
            print $table_ref->{'body'} if $table_ref->{'rows'} > 0;
        }
        
        print "\nRows returned: " . $table_ref->{'rows'} . "\n";
    }
    else {
        print "\nRows affected: " . $table_ref->{'rows'} . "\n";
    }

    # Display last command executed...
    print "SQL: ${cmd_buffer}\n";

    return;
}
