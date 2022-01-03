
############# This is very helpful for debugging
#for($i=1;$i<=100;$i++){
# $atomcount=sprintf("%03d",$i);
# unlink "$atomcount.dat";
#}

############# for opening many files in sequence
for($i=1;$i<=100;$i++){
 $atomcount=sprintf("%03d",$i);
 open temp,">$atomcount.dat";
 print temp "This is a test for $i times";
 close temp;
}


#for($i=1;$i<=100;$i++){
# $atomcount=sprintf("%03d",$i);## output to a parameter
# open temp,">$atomcount.dat";
# printf temp "This is a test for %03d times",$i; # print data by the assigned format
# close temp;
#}