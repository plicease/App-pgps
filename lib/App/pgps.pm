use strict;
use warnings;
use 5.020;
use experimental 'postderef';
use experimental 'signatures';

package App::pgps {

  # ABSTRACT: PostgreSQL ps

  use DBI;
  use Test2::Util::Table qw( table );

=head1 METHODS

=head2 main

 App::pgps->main(@arguments);

=cut

  sub main ($class, @args)
  {
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
      push @rows, [@$row];
    }

    say $_ for table(
      collapse => 1,
      header   => [qw( pid user address state query )],
      sanitize => 1,
      rows     => \@rows,
    );    
    
  }

  0;
}

1;

=head1 SEE ALSO

L<pgps>

=cut


