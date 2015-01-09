require 5.008;
use strict;
use warnings;

use File::Spec::Functions qw(catfile);

my $module    = 'Module::Extract::Use';
my $github    = 'https://github.com/briandfoy/module-extract-use';
my $main_file = catfile( 'lib', split /::/, "$module.pm" );

my %WriteMakefile = (
	'NAME'	        => $module,
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => 'lib/Module/Extract/Use.pm',
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',

	'CONFIGURE_REQUIRES' => {
		'ExtUtils::MakeMaker'   => '6.64',
		'File::Spec::Functions' => '0',
		},

	'BUILD_REQUIRES' => {
		},

	'TEST_REQUIRES' => {
		'Test::More' => '0.94',
		'Test::Output' => '0',
		},

	'PREREQ_PM'     => {
		'PPI'          => '0',
		},

	'META_MERGE' => {
		'meta-spec' => { version => 2 },
		keywords => [ qw( ppi parsing static-analysis modules ) ],
		resources => {
			repository => {
				type => 'git',
				url  => "$github.git",
				web  => $github,
				},
			bugtraker => {
				web    => "$github/issues",
				},
			homepage => $github,
			},
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
			||
		"$MM 6.64";
	eval "use $MM_version; 1" or die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
