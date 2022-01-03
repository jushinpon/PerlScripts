$x1 = 'abc';
$x2 = "abc";
$x3 = 1;
$x4 = 3;
@array = ('abc',"abc",1,3);
%hash=("x1","abc","x2","abc","x3","1","x4","3");

$x1ref =\$x1; #get the address in RAM disk

print "x1ref is $x1ref \n";
print "x1 is $$x1ref\n";


$arrayref = \@array;

print "arrayref is $arrayref \n";# show the array information here
print "array is @$arrayref\n"; # print all elements
print "element 0 is $$arrayref[0]\n"; # get element from a reference
print "element 0 is $arrayref->[0]\n";  # get element from a reference

$hashref = \%hash;

print "hashref is $hashref \n";
print  %$hashref ; # show the hash information here
print " ";
print "key x1 is $$hashref{'x1'}\n"; # get key value from a reference
print "key x1 is $$hashref{x1}\n"; # get key value from a reference
print "key x1 is $hashref->{'x1'}\n";  # get key value from a reference
print "key x1 is $hashref->{x1}\n";  # get key value from a reference