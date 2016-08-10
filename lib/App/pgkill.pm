package App::pgkill;

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

 App::pgkill->main(@arguments);

=cut

sub main
{
  my(undef, @args) = @_;

  GetOptionsFromArray(\@args);

  my $dbh = DBI->connect('dbi:Pg:dbname=postgres', '', '', { RaiseError => 1 });

  my $pid = shift @args;
  
  unless(defined $pid && $pid =~ /^[0-9]+$/)
  {
    say STDERR "usage: pgkill pid";
    return 2;
  }
  
  $dbh->do(q{ SELECT pg_cancel_backend(?) }, {}, $pid);
  
  0;
}

1;
  
=head1 SEE ALSO

L<pgkill>

=cut

