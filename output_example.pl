open ss,"<grade_sheet.txt";
@input=<ss>;  #read data from ss line by line to an array
close ss;
print  "@input\n"; # print on the screen

open outtest,">output_test.txt";
print "@input";      #on screen
print outtest "@input";   #on file
close outtest;