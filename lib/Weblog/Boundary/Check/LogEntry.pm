package Weblog::Boundary::Check::LogEntry;

use strictures 2;
use Moo;
use Types::Standard qw/Str/;

use namespace::clean;

has url           => ( is => 'ro', isa => Str );
has referer       => ( is => 'ro', isa => Str );
has original_line => ( is => 'ro', isa => Str );

1;
