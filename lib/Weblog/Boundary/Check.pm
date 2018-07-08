package Weblog::Boundary::Check;

# ABSTRACT: analyze web server logs for boundary breaches.

use strictures 2;
use Moo;
use Types::Standard qw/ArrayRef/;

our $VERSION = '0.001';

use namespace::clean;

has breach_patterns => ( is => 'ro', isa => ArrayRef );
has false_positives => ( is => 'ro', isa => ArrayRef );

sub new_from_config {
    my ($self, $filename) = @_;

    # load in the patterns/false positives from a config file.
    # what format?
    # let's go json
    my $args = {};
    return __PACKAGE__->new($args);
}

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
                push @{ $errors{ $pattern->key } }, $log_entry;
                next ENTRY;
            }
        }
    }

    # could do with some sort of summarization of the lists
    return \%errors;
}

1;
