### Get the information you want first!
open ss,"<grade_sheet-four.txt";
@input=<ss>;
close ss;

# get the header !!
print "Before trim: $input[0]\n";
$input[0] =~s/^\s+//g;#replace operation 
##$input[0] =~s/^\s+/123/g; ####

print "After  trim: $input[0]\n";

@header = split(/\s+/,$input[0]);
$header_num = @header; #***check this if you don't use "=~s/^\s+//g" to remove the beginning empty
print "**** The number of header: $header_num\n";
$i=0;
foreach (@header){	
print "$i term:  $_\n";
$i=$i+1;	
}

## open files to write data into 
# $i=1, becuse we want to open files named by the courses
for ($i=1;$i<=$header_num;$i++) { 
$temp = $header[$i];	
open $temp,">$temp".".txt"; # the first "." is the combination operator of Perl
}

## Now let's write data into different files, we will use them in the future.

##*********** by yourself

###### close files

for ($i=1;$i<=$header_num;$i++) { 
$temp = $header[$i];	
close $temp; 
}