#!/usr/bin/perl
use strict;

use Test::More 'no_plan';
use File::Basename;

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

$extor->get_modules( $not_there );
like( $extor->error, qr/does not exist/, "Missing file give right error" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file PPI can't parse, should fail
{
open my($fh), ">", "empty";
close $fh;
END{ unlink 'empty' }

my $unparseable = 'empty';
ok( -e $unparseable, "Unparseable file is there" );

$extor->get_modules( $unparseable );
like( $extor->error, qr/not parse/, "Unparseable file gives right error" );
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with this file
{
my $test = $0;
ok( -e $test, "Test file is there" );

my %modules = map { $_, 1 } $extor->get_modules( $test );

foreach my $module ( qw(Test::More File::Basename) )
	{
	ok( exists $modules{$module}, "Found $module" );
	ok( ! $extor->error, "No error for parseable file [$module]")
	}

}