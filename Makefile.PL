use ExtUtils::MakeMaker 6.48;

require 5.008;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'	       => 'Module::Extract::Use',
	'ABSTRACT'     => 'Extract the modules that a modules uses',
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
