open ss,"<log.lammps";
@input=<ss>;  #read data from ss line by line to an array
close ss;
#@temp = grep (/elast : /,@input); #any item with "elast"
@temp = grep (/^elast : /,@input); #any item with "elast" of the first five letters

#print @temp;

open ss,">MC_Energy.dat";
$lineNo = @temp; #The total element number


for($i=0;$i<$lineNo;$i++){
@energy = " ";
@energy=split(/\s+/,$temp[$i]);
printf ss "%d %8.3f \n",$i,$energy[4];
}
close ss;