#! /usr/local/bin/perl -w # -*- perl -*-

# $Id: Makefile.PL,v 1.3 2005/11/14 23:29:54 guido Exp $

# Makefile generator for Data-Find.
# Copyright (C) 2005 Guido Flohr <guido@imperia.net>, 
# all rights reserved.

# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.

# You should have received a copy of the GNU Library General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
# USA.use ExtUtils::MakeMaker;

use 5.004;
use ExtUtils::MakeMaker;

WriteMakefile (
    NAME		    => 'Data::Traverse',
    VERSION_FROM	=> 'lib/Data/Traverse.pm',
    ($] >= 5.005 ?
		(ABSTRACT	=> 'Traverse Perl data structures.',
	 	 AUTHOR		=> 'Guido Flohr <guido@imperia.net>',
    ) : (),
    ),
    PREREQ_PM => {},
    PL_FILES => {},
    (MM->can ('signature_target') ? (SIGN => 1) : ()),
    LICENSE => 'lgpl',
);

sub MY::postamble {
   	q ( 
all :: README ReleaseNotes

README: lib/Data/Traverse.pm
	$(PERL) -e 'use Pod::Text; pod2text "lib/Data/Traverse.pm"' >README

# Make search.cpan.org happy but still follow GNU standards:
# (Thanks to Graham Barr for the hint)
ReleaseNotes: NEWS
	cat NEWS >$@
	);
}

__END__

Local Variables:
mode: perl
perl-indent-level: 4
perl-continued-statement-offset: 4
perl-continued-brace-offset: 0
perl-brace-offset: -4
perl-brace-imaginary-offset: 0
perl-label-offset: -4
cperl-indent-level: 4
cperl-continued-statement-offset: 2
tab-width: 8
End:
