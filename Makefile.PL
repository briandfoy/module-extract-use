# $Id: Makefile.PL,v 1.4 2004/07/04 17:04:17 comdog Exp $
use ExtUtils::MakeMaker;

require 5.006;

eval "use Test::Manifest 1.14";

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

	'MAN3PODS'     => {
		'lib/Use.pm' => '$(INST_MAN3DIR)/Module::Extract::Use.3',
		},

	clean  => { FILES    => q|Module-Extract-Use-*| },

	);
