use ExtUtils::MakeMaker;

require 5.006;

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

	(
	$ExtUtils::MakeMaker::VERSION ge '6.48' ? 
		(
		MIN_PERL_VERSION => 5.006,

		META_MERGE       => {
			resources => {
		  		repository => 'git://github.com/briandfoy/module--extract--use.git',
				},
			keywords => ['ppi', 'parsing', 'static-analysis', 'modules'],
	  		},
	 	) 
	 	: 
	 	()
	 ),
		
	clean  => { FILES    => q|Module-Extract-Use-*| },

	);
