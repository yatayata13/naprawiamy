use FixMyStreet::Test;
use Test::More;

BEGIN {
    use_ok('FixMyStreet::Cobrand::zabrze');
}

my $cobrand = FixMyStreet::Cobrand::zabrze->new;
isa_ok($cobrand, 'FixMyStreet::Cobrand::zabrze');

done_testing();
