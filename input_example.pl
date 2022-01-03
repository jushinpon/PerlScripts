#####............input from keyboard............

#print "Please type some words for test:\n";
#$input=<STDIN>; # standard input by the keyboard
#print "input: $input\n";

#####...............input from file.............
# the first way

#open ss,"<grade_sheet.txt";
#@input=<ss>;  #read data from ss line by line to an array
#close ss;
#print  "@input\n";

# the second way

#$allpart = "";
#open ss,"<grade_sheet.txt";
#while($_=<ss>){$allpart.=$_;}
#close ss;
#print $allpart;

#####.............build-in-data....................
#$line="hello world!";
#print "$line\n";