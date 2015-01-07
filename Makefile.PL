require 5.008;
use strict;
use warnings;

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/';

my %WriteMakefile = (
	'NAME'	       => 'Module::Extract::Use',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM' => 'lib/Module/Extract/Use.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'    => { 
		'PPI'          => '0',
		'Test::More'   => '0',
		'Test::Output' => '0',
		},

	META_MERGE       => {
		resources => {
			repository => {
				type => 'git',
				url  => 'git@github.com:briandfoy/module-extract-use.git',
				web  => 'https://github.com/briandfoy/module-extract-use',
				},
			},
		keywords => [ qw( ppi parsing static-analysis modules ) ],
		no_index => {
			dir       => [ qw(corpus) ],
			directory => [ qw(corpus) ],
			},
		},
		
	clean  => { FILES    => q|Module-Extract-Use-*| },
	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version" || die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
