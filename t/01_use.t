use strict;
use warnings;
use Test::More;
use Test::Script;

use_ok 'App::pgps';
use_ok 'App::pgkill';
script_compiles_ok 'bin/pgps';
script_compiles_ok 'bin/pgkill';

done_testing;
