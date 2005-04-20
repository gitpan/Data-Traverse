package Data::Traverse;

use 5.008004;
use strict;
use warnings;

use Exporter;
use Carp;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
our @EXPORT_OK = ('&traverse');


our $VERSION = '0.01';


# Preloaded methods go here.

# Use this sub to do the prototype only. The real fun
# happens real_traverse.
sub traverse(&$) { 
    my ( $callback, $ref ) = @_;
    my $type = ref $ref or 
	croak "Second argument to traverse must be a reference";

    real_traverse( $callback, $ref, $type, caller );


}


sub real_traverse { 
    my ( $callback, $ref, $type, $caller ) = @_;

    no strict 'refs';
    local(*{$caller."::a"}) = \my $a;
    local(*{$caller."::b"}) = \my $b;
    use strict 'refs';

    if ( $type eq 'ARRAY' ) { 
	foreach my $item( @$ref ) {
	    $_ = $type;
	    my $st = ref( $item );
	    if( $st ) { 
		real_traverse( $callback, $item, $st, $caller );
	    } else { 
		$a = $item;
		$callback->();
	    }
	}
    } elsif ( $type eq 'HASH' ) { 
	while( my ( $key, $val ) = each %$ref ) { 
	    $_ = $type;
	    my $st = ref( $val );
	    if( $st ) { 
		real_traverse( $callback, $val, $st, $caller );
	    } else { 
		$a = $key;
		$b = $val;
		$callback->();
	    }
	}
    } else { 
	croak "Encountered unsupported type $type in traverse";
    }
}


1;
__END__

=head1 NAME

Data::Traverse - Callback-based depth-first traversal of Perl data structures

=head1 SYNOPSIS

  use Data::Traverse qw(traverse);
  
  my $struct = [ 1, 2, { foo => 42 }, [ 3, 4, [ 5, 6, { bar => 43 } ] ], 7, 8 ];
  traverse { print "$a\n" if /ARRAY/; print "$a => $b\n" if /HASH/ } $struct;

=head1 DESCRIPTION

Data::Traverse exports a single function, traverse, which takes a BLOCK and 
a reference to a data structure containing arrays or hashes. Objects, globs
and other things are not supported. Data::Traverse performs a depth-first
traversal of the structure and calls the code in the BLOCK for each scalar
it finds. $_ is set to the type of the container ('ARRAY' or 'HASH'). For 
arrays, the magic variable $a contains the data. For hashes, the magic 
variables $a and $b contain the key and the value, respectively.

=head2 EXPORT

&traverse.

None by default.


=head1 AUTHOR

Mike Friedman, <friedo at friedo dot com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Mike Friedman

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
