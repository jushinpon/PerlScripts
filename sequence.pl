open ss,"<data.dat";

@input=<ss>;  #read data from ss line by line to an array
close ss;

@sequence= sort(@input);

print @sequence;

$last =$#sequence;

print "The maximal number is $sequence[$last]";