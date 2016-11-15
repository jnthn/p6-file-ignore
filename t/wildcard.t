use File::Ignore;
use Test;

my $ig = File::Ignore.parse(q:to/LIST/);
    *.swp
    dir*/
    /*.tmp
    result?.txt
    LIST

nok $ig.ignore-file('alright'), 'Do not ignore files not in ignore list';
nok $ig.ignore-directory('alright'), 'Do not ignore directories not in ignore list';

ok $ig.ignore-file('foo.swp'), '"*.swp" ignores file foo.swp';
ok $ig.ignore-directory('foo.swp'), '"*.swp" ignores directory foo.swp';
ok $ig.ignore-file('.swp'), '"*.swp" ignores file .swp';
ok $ig.ignore-directory('.swp'), '"*.swp" ignores directory .swp';
ok $ig.ignore-file('bar/foo.swp'), '"*.swp" ignores file bar/foo.swp';
ok $ig.ignore-directory('bar/foo.swp'), '"*.swp" ignores directory bar/foo.swp';
ok $ig.ignore-file('bar/.swp'), '"*.swp" ignores file bar/.swp';
ok $ig.ignore-directory('bar/.swp'), '"*.swp" ignores directory bar/.swp';
nok $ig.ignore-file('x.swpe'), '"*.swp" does not ignore file x.swpe';
nok $ig.ignore-directory('x.swpe'), '"*.swp" does not ignore directory x.swpe';

nok $ig.ignore-file('dir21'), '"dir*/" does not ignore file dir21';
ok $ig.ignore-directory('dir21'), '"dir*/" ignores directory dir21';
nok $ig.ignore-file('foo/dir21'), '"dir*/" does not ignore file foo/dir21';
ok $ig.ignore-directory('foo/dir21'), '"dir*/" ignores directory foo/dir21';

ok $ig.ignore-file('x.tmp'), '"/*.tmp" ignores file x.tmp';
ok $ig.ignore-directory('x.tmp'), '"/*.tmp" ignores directory x.tmp';
nok $ig.ignore-file('subby/x.tmp'), '"/*.tmp" does not ignore file subby/x.tmp';
nok $ig.ignore-directory('subby/x.tmp'), '"/*.tmp" does not ignore directory subby/x.tmp';

nok $ig.ignore-file('result.txt'), '"result?.txt" does not ignore file result.txt';
nok $ig.ignore-directory('result.txt'), '"result?.txt" does not ignore directory result.txt';
ok $ig.ignore-file('result1.txt'), '"result?.txt" ignores file result1.txt';
ok $ig.ignore-directory('result1.txt'), '"result?.txt" ignores directory result1.txt';
nok $ig.ignore-file('result22.txt'), '"result?.txt" does not ignore file result22.txt';
nok $ig.ignore-directory('result22.txt'), '"result?.txt" does not ignore directory result22.txt';

done-testing;
