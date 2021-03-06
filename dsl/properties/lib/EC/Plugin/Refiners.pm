package EC::Plugin::Refiners;

use strict;
use warnings;

=head1 SYNOPSIS

Refiners are used to transform field value in some way. E.g. we have in our config

    property: myProp
    type: checkbox
    refiner: convert_checkbox


And we want value 'info' in case of TRUE and undefined otherwize.
Then we have to add refiner (subroutine), named convert_checkbox:

    sub convert_checkbox {
        my ($self, $value) = @_;

        return $value ? 'info' : undef;
    }

No refiners are created by default.

=cut

sub convert_not_set {
    my ($self, $value) = @_;

    return $value ne '__IS__NOT__SET__' ? $value : undef;
}

sub remove_blank {
    my ($self, $value) = @_;
    return undef unless $value;
}


sub convert_to_int {
    my ($self, $value) = @_;
    if ($value){
        eval { $value = 0 + $value };
        $self->plugin->logger->debug("Value is not INT?\n".$@) if $@;
    }
    return $value;
}

sub convert_to_boolean {
    my ($self, $value) = @_;
    if ($value eq 'true'){
        $value = \1;
    }
    else{
        $value = \0;
    }
    return $value;
}

sub new {
    my ($class) = @_;
    return bless {}, $class;
}

1;
