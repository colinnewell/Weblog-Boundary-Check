use Test2::V0;

use Weblog::Boundary::Check::Pattern;
use Weblog::Boundary::Check::LogEntry;

my $bad_entry = Weblog::Boundary::Check::LogEntry->new(
    method  => 'POST',
    referer => '/admin/thing',
    url     => '/some-url',
);
my $good_entry = Weblog::Boundary::Check::LogEntry->new(
    method  => 'POST',
    referer => '/admin/foo',
    url     => '/admin/thing',
);

my $p = Weblog::Boundary::Check::Pattern->new(
    method  => qr|^POST$|i,
    referer => qr|^/admin/|,
    url     => qr|^/(?!admin/)|,
);
ok $p->match($bad_entry);
ok !$p->match($good_entry);

done_testing;
