use Test2::V0;

use Weblog::Boundary::Check::Pattern;
use Weblog::Boundary::Check::LogEntry;

my $bad_entry = Weblog::Boundary::Check::LogEntry->new(
    url     => '/some-url',
    referer => '/admin/thing'
);
my $good_entry = Weblog::Boundary::Check::LogEntry->new(
    url     => '/admin/thing',
    referer => '/admin/foo'
);

my $p = Weblog::Boundary::Check::Pattern->new(
    url => qr|^/(?!admin/)|,
    referer => qr|^/admin/|
);
ok $p->match($bad_entry);
ok !$p->match($good_entry);

done_testing;
