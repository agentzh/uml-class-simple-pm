use Test::More tests => 4;

# This script tests whether UML::Class::Simple draws a diagram
# that only includes modules that appear when using the target module.

# UML::Class::Simple should not draw any modules that appear
# only as a side effect of using UML::Class::Simple, PPI, etc.

use lib "lib";
use lib "t/data";

use_ok UML::Class::Simple;
use_ok UMLClassTest;

{
  my @expect = map { chomp; $_ } sort { $a cmp $b }
                 `$^X -It/data t/data/classes-from-runtime.pl`;
  my @got = grep { $_ } sort { $a cmp $b } classes_from_runtime("UMLClassTest");
  is_deeply(\@got, \@expect, 'Find exactly the modules that are loaded');
  # print "\n\nGot: @got\n\nExpected: @expect\n";
}

{
  my @expect = map { chomp; $_ } sort { $a cmp $b } `$^X t/data/filespec.pl`;
  my @got = grep { $_ } sort { $a cmp $b } classes_from_runtime("File::Spec");
  is_deeply(\@got, \@expect, 'Same test; dependency overlap with U::C::S');
  # print "\n\nGot: @got\n\nExpected: @expect\n";
}

