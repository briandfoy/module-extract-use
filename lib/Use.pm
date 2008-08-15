# $Id$
package Module::Extract::Use;
use strict;

use warnings;
no warnings;

use subs qw();
use vars qw($VERSION);

use Carp qw(carp);

$VERSION = '0.10_01';

=head1 NAME

Module::Extract::Use - Pull out the modules a module uses

=head1 SYNOPSIS

	use Module::Extract::Use;

	my $extor = Module::Extract::Use->new;
	
	my @modules = $extor->get_modules( $file );
	
	
=head1 DESCRIPTION

=cut

=over 4

=item new

Makes an object. The object doesn't do anything just yet, but you
need it to call the methods.

=cut

sub new 
	{ 
	my $class = shift;
	
	bless {}, $class;
	}

=item get_modules( FILE )

Returns a list of namespaces explicity use-d in FILE. Returns undef if the
file does not exist or if it can't parse the file.

=cut

sub get_modules {
	my( $self, $file ) = @_;
	
	return unless -e $file;
	
	require PPI;

	carp "File does not exist!" unless -e $file;
	
	my $Document = PPI::Document->new( $file );
	unless( $Document )
		{
		carp( "Could not parse file [$file]" );
		return;
		}
		
	my $modules = $Document->find( 
		sub {
			$_[1]->isa( 'PPI::Statement::Include' )  && $_[1]->type eq 'use'
			}
		);
	
	return unless $modules;
	
	my @modules = map { $_->module } @$modules;

	@modules;
	}

=back

=head1 TO DO


=head1 SEE ALSO


=head1 SOURCE AVAILABILITY

This source is part of a SourceForge project which always has the
latest sources in CVS, as well as all of the previous releases.

	http://sourceforge.net/projects/brian-d-foy/

If, for some reason, I disappear from the world, one of the other
members of the project can shepherd this module appropriately.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2008, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

1;
