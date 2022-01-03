@array = ('abc',"abc",1,3);
$x1 = 123;
&test;
#&test1($x1,\@array);
&test1($x1,@array);
sub test{	
print " The following data are shown in Subroutine\n";
print "x1 is $x1\n";	
for($i=0;$i<=3;$i++){
print "$array[$i]\n"; #array starts from element label 0
}
}

sub test1{
#my ($a1,$a2)=@_ ;#local parameters a1 and a2, and a2 is a referece for array
my ($a1,@a2)=@_;
print " The following data are shown in Subroutine\n";
print "a1 is $a1\n";	
for($i=0;$i<=3;$i++){
#print "$$a2[$i]\n"; #array starts from element label 0
print "$a2[$i]\n";
}
}