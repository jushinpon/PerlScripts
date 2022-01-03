open ss,"<grade_sheet-four.txt";
while($_=<ss>){$allpart.=$_;}
close ss;
#print $allpart;
@temp=split(/\n/,$allpart);
print " The information of the first line is $temp[0]\n";

#@temp1=split(/\s+/,$temp[0]);
@temp1=split(' ',$temp[0]);## remove the empty space at the first
print "temp1 is @temp1\n";
print " temp1[0] is $temp1[0]";

