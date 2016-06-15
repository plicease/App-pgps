package App::pgps;

use strict;
use warnings;
use 5.012;
use DBI;
use Test2::Util::Table qw( table );
use Getopt::Long qw( GetOptionsFromArray );

# ABSTRACT: PostgreSQL ps
# VERSION

=head1 METHODS

=head2 main

 App::pgps->main(@arguments);

=cut

sub main
{
  my($class, @args) = @_;
  
  my $active = 0;
  
  GetOptionsFromArray(\@args, "a" => \$active);
  
  my $dbh = DBI->connect('dbi:Pg:dbname=postgres', '', '');
    
  my $sth = $dbh->prepare(join ' ', do { no warnings; qw{
    SELECT
      pid,
      usename,
      client_addr,
      state,
      CASE WHEN state = 'active' THEN query ELSE '' END
    FROM
      pg_stat_activity
  }});
    
  $sth->execute;
    
  my @rows;
  while(my $row = $sth->fetchrow_arrayref)
  {
    next if $active && $row->[3] eq 'idle';
    push @rows, [@$row];
  }

  say $_ for table(
    collapse => 1,
    header   => [qw( pid user address state query )],
    sanitize => 1,
    rows     => \@rows,
  );    

  0;    
}

1;

=head1 SEE ALSO

L<pgps>

=cut


