use strict;
use warnings;
use Test::More;
use Test::Script;

use_ok 'App::pgps';
script_compiles_ok 'bin/pgps';

done_testing;
