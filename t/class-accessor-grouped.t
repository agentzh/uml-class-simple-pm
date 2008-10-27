use strict;
use warnings;

# vi:filetype=
my $skip;
BEGIN {
    eval "use Class::Accessor::Grouped";
    if ($@) { $skip = 'Class::Accessor::Grouped required to run this test' }
}
use Test::More $skip ? (skip_all => $skip) : ();
use UML::Class::Simple;
use Data::Dumper;

$Data::Dumper::Indent = 1;
$Data::Dumper::Sortkeys=1;

plan tests => 1;

require "t/data/TestClassAccessorGrouped.pm";
my $painter = UML::Class::Simple->new(['TestClassAccessorGrouped']);

my $dom = $painter->as_dom;

is Dumper($dom), <<'_EOC_';
$VAR1 = {
  'classes' => [
    {
      'methods' => [
        'blah'
      ],
      'name' => 'TestClassAccessorGrouped',
      'properties' => [
        'lr1name',
        'lr2name',
        'multiple1',
        'multiple2',
        'result_class',
        'singlefield'
      ],
      'subclasses' => []
    }
  ]
};
_EOC_

