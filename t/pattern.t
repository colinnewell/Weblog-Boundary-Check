use Test2::V0;

use Weblog::Boundary::Check::Pattern;
use Weblog::Boundary::Check::LogEntry;

my $bad_entry = Weblog::Boundary::Check::LogEntry->new(
    method  => 'POST',
    referer => '/admin/thing',
    url     => '/some-url',
);
my $static_entry = Weblog::Boundary::Check::LogEntry->new(
    method  => 'GET',
    referer => '/admin/thing',
    url     => '/static/test.txt',
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

my $fp = Weblog::Boundary::Check::Pattern->new(
    url     => qr|^/static/|,
);
ok ! $fp->match($bad_entry);
ok ! $fp->match($good_entry);
ok $fp->match($static_entry);

done_testing;
