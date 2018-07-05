package Weblog::Boundary::Check;

# ABSTRACT: analyze web server logs for boundary breaches.

use strictures 2;
use Moo;
use Types::Standard qw/ArrayRef/;

our $VERSION = '0.001';

has breach_patterns => ( is => 'ro', isa => ArrayRef );
has false_positives => ( is => 'ro', isa => ArrayRef );

sub analyze_log {
    my ( $self, $log ) = @_;

    my %errors;
  ENTRY: while ( my $log_entry = $log->next_entry() ) {
        for my $pattern ( @{ $self->breach_patterns } ) {
            if ( $pattern->match($log_entry) ) {
                for my $false_positive ( @{ $self->false_positives } ) {
                    if ( $false_positive->match($log_entry) ) {
                        next ENTRY;
                    }
                }
                push @{ $errors{ $pattern->key } }, $entry;
                next ENTRY;
            }
        }
    }

    # could do with some sort of summarization of the lists
    return \%errors;
}

1;
