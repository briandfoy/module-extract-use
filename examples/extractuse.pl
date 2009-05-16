#!/usr/bin/perl

use strict;
use warnings;

use Pod::Usage;

=head1 NAME

extractuse - determine what Perl modules are used in a given file

=head1 VERSION

Version 1.0

=cut

use version; our $VERSION = qv('1.0');

=head1 SYNOPSIS

Usage: extractuse filename [...]

Given a single path referring to a file containing Perl code, this script will
determine the modules included statically. This means that files included
by C<use> and C<require> will be retrieved and listed.

=head1 DESCRIPTION

This script is safe because the Perl code is never executed, only parsed by
C<Module::Extract::Use> or C<Module::ExtractUse>, which are two different
implementations of this idea. This module will prefer C<Module::Extract::Use>
if it is installed, because it uses PPI to do its parsing, rather than its
own separate grammar.

However, one limitation of this script is that only statically included
modules can be found - that is, they have to be C<use>'d or C<require>'d
at runtime, and not inside an eval string, for example. Because eval strings
are completely dynamic, there is no way of determining which modules might
be loaded under different conditions.

=cut

my @files = @ARGV;
my $class = 'Module::Extract::Use';

# if no parameters are passed, give usage information
unless( @files ) 
	{
	pod2usage( msg => 'Please supply at least one filename to analyze' );
	exit;
	}

my( $object, $method );
my @classes = qw( Module::Extract::Use Module::ExtractUse );
my %methods = qw(
	Module::Extract::Use get_modules
	Module::ExtractUse   extract_use
	);
	
foreach my $module ( @classes )
	{
	eval "require $module";
	next if $@;
	( $object, $method ) = ( $module->new, $methods{$module} );
	}	

die "No usable file scanner module found; exiting...\n" unless defined $object;


foreach my $file (@files) 
	{
	unless ( -r $file ) 
		{
		printf STDERR "Failed to open file '$file' for reading\n";
		next;
		}

	dump_list( $file, $object->$method( $file );
	}
	

BEGIN {
my $corelist = eval { require Module::CoreList };

sub dump_list 
	{
	my( $file, @modules ) = @_;

	printf "Modules required by %s:\n", $file;

	my( $core, $extern ) = ( 0, 0 );

	foreach my $module ( @modules ) 
		{
		printf " - $module %s\n",
				$corelist
					?
					do {
						my $v = Module::CoreList->first_release( $name );
						$core++ if $v;
						$v ? " (first released with Perl %v)" : '';
						}
					:
					do { $extern++; '' }
		}

	printf "%d module(s) in core, %d external module(s)\n\n", $core, $extern;
	}
	
}

=head1 AUTHOR

Jonathan Yu C<< <frequency@cpan.org> >>


=head1 COPYRIGHT & LICENSE

Copyright 2009 by Jonathan Yu <frequency@cpan.org>

You can use this script under the same terms as Perl itself.

=head1 SEE ALSO

L<Module::Extract::Use>,
L<Module::ExtractUse>,
L<Module::ScanDeps>,

=cut
