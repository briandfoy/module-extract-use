#!/usr/bin/perl
use strict;

use Test::More tests => 6;
use File::Basename;
use File::Spec::Functions qw(catfile);

my $class = "Module::Extract::Use";
use_ok( $class );

my $extor = $class->new;
isa_ok( $extor, $class );
can_ok( $extor, 'get_modules_with_details' );


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Try it with a file that has repeated use lines
# I should only get unique names
{
my $file = catfile( qw(corpus PackageImports.pm) );
ok( -e $file, "Test file [$file] is there" );

my $details = $extor->get_modules_with_details( $file );
is( scalar @$details, 10, 'There are the right number of hits' );

is_deeply( $details, expected(), 'The data structures match' );
}


sub expected {
	return  [
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [],
            'module' => 'URI'
          },
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [
                           ':standard'
                         ],
            'module' => 'CGI'
          },
          {
            'pragma' => '',
            'version' => '1.23',
            'imports' => [
                           'getstore'
                         ],
            'module' => 'LWP::Simple'
          },
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [
                           'basename',
                           'dirname'
                         ],
            'module' => 'File::Basename'
          },
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [
                           'catfile',
                           'rel2abs'
                         ],
            'module' => 'File::Spec::Functions'
          },
          {
            'pragma' => 'autodie',
            'version' => undef,
            'imports' => [
                           ':open'
                         ],
            'module' => 'autodie'
          },
          {
            'pragma' => 'strict',
            'version' => undef,
            'imports' => [
                           'refs'
                         ],
            'module' => 'strict'
          },
          {
            'pragma' => 'warnings',
            'version' => undef,
            'imports' => [
                           'redefine'
                         ],
            'module' => 'warnings'
          },
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [
                           'brush'
                         ],
            'module' => 'Buster'
          },
          {
            'pragma' => '',
            'version' => undef,
            'imports' => [
                           'string'
                         ],
            'module' => 'Mimi'
          }
        ];

	}
