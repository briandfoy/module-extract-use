#!/usr/bin/perl
use strict;

use Test::More tests => 13;
use File::Basename;
use File::Spec::Functions qw(catfile);

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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file that has repeated use lines
# I should only get unique names
{
my $file = catfile( qw(corpus Repeated.pm) );
ok( -e $file, "Test file [$file] is there" );

my @modules = sort { $a cmp $b } $extor->get_modules( $file );
is( scalar @modules, 3 );

is_deeply( \@modules, [qw(constant strict warnings)] );
}
