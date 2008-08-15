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

Extract the names of the modules used in a file using a static analysis.
Since this module does not run code, it cannot find dynamic uses of
modules, such as C<eval "require $class">.

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
		

	carp "File does not exist!" unless -e $file;
	
	require PPI;

	my $Document = eval { PPI::Document->new( $file ) };
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
	
	my @modules = eval { map { $_->module } @$modules };

	@modules;
	}

=back

=head1 TO DO

* Make it recursive, so it scans the source for any module that
it finds.

=head1 SEE ALSO

L<Module::ScanDeps>

=head1 SOURCE AVAILABILITY

I have a git archive for this. If you'd like to clone it,
just ask.

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2008, brian d foy, All Rights Reserved.

You may redistribute this under the same terms as Perl itself.

=cut

1;
