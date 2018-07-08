package Weblog::Boundary::Check::Pattern;

use strictures 2;
use Moo;
use Types::Standard qw/RegexpRef/;

use namespace::clean;

has method  => ( is => 'ro', isa => RegexpRef );
has referer => ( is => 'ro', isa => RegexpRef );
has url     => ( is => 'ro', isa => RegexpRef );

sub match {
    my ( $self, $log_entry ) = @_;

    if (   $log_entry->method =~ $self->method
        && $log_entry->url =~ $self->url
        && $log_entry->referer =~ $self->referer )
    {
        return 1;
    }
    return 0;
}

1;
