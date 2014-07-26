use strict;
use utf8;

use Test::More tests => 3;

use Text::Boustrophedon;

my $val = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ and some other junk";
is(length($val), length(Text::Boustrophedon::mirror($val)), 'mirror len is same');
is(length($val), length(Text::Boustrophedon::flipped($val)), 'flipped len is same');
is(length($val), length(Text::Boustrophedon::upsidedown($val)), 'upsidedown len is same');
