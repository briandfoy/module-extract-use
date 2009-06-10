use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'	       => 'Module::Extract::Use',
	'ABSTRACT'     => 'Extract the modules that a modules uses',
	'VERSION_FROM' => 'lib/Use.pm',
	'LICENSE'      => 'perl',
	'AUTHOR'       => 'brian d foy <bdfoy@cpan.org>',
	
	'PREREQ_PM'    => { 
		'PPI'          => '0',
		'Test::More'   => '0',
		'Test::Output' => '0',
		},

	'PM'           => {
		'lib/Use.pm'         => '$(INST_LIBDIR)/Use.pm',
		},

	(
	$ExtUtils::MakeMaker::VERSION ge '6.48' ? 
		(
		MIN_PERL_VERSION => 5.006,

		META_MERGE       => {
			resources => {
		  		repository => 'git://github.com/briandfoy/module--extract--use.git',
				},
			keywords => ['testing','STDOUT','STDERR'],
	  		},
	 	) 
	 	: 
	 	()
	 ),

	'MAN3PODS'     => {
		'lib/Use.pm' => '$(INST_MAN3DIR)/Module::Extract::Use.$(MAN3EXT)',
		},
		
	clean  => { FILES    => q|Module-Extract-Use-*| },

	);
