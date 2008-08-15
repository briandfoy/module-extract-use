#!/usr/bin/perl
use strict;

use Test::More 'no_plan';
use Test::Output;

my $class = "Module::Extract::Use";

use_ok( $class );

my $extor = $class->new;
isa_ok( $extor, $class );
can_ok( $extor, 'get_modules' );

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file that doesn't exist, should fail
{
my $not_there = 'not_there';
ok( ! -e $not_there, "Missing file is actually missing" );

stderr_like
	{ $extor->get_modules( $not_there ) }
	qr/does not exist/,
	"Carps for missing file";

no strict 'refs';
no warnings 'redefine';
local *{"${class}::carp"} = sub { '' };
my $rc = eval { $extor->get_modules( $not_there ) };
is( $rc, undef, "Returns undef for missing file" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file PPI can't parse, should fail
{
open my($fh), ">", "empty";
close $fh;
END{ unlink 'empty' }

my $unparseable = 'empty';
ok( -e $unparseable, "Unparseable file is there" );

stderr_like
	{ $extor->get_modules( $unparseable ) }
	qr/not parse/,
	"Carps for unparseable file";
	
no strict 'refs';
no warnings 'redefine';
local *{"${class}::carp"} = sub { '' };
my $rc = eval { $extor->get_modules( $unparseable ) };
is( $rc, undef, "Returns undef for unparseable file" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with this file
{
my $test = $0;
ok( -e $test, "Test file is there" );

my %modules = map { $_, 1 } $extor->get_modules( $test );

foreach my $module ( qw(Test::More Test::Output) )
	{
	ok( exists $modules{$module}, "Found $module" );
	}

}