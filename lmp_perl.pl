
#remove files
unlink "lattice_Energy.dat";

## read the template file
$allpart = "";
open ss,"<FCC_Ag_template.in"; 
while($_=<ss>){$allpart.=$_;}
close ss;


$number= (4.3-3.9)/0.01; # the number for loop

for($i=0;$i<=$number;$i++){
#for($i=0;$i<=0;$i++){ ###use this for check first
$temp = 3.9+$i*0.01; ### lattice you want to use 
$filename= "Struc_"	. "$i" . ".data"; ### the file name for structure output
$scriptname = "FCC_Ag_perl_$i.in";

#### making lammps script
open ss,">$scriptname"; 
printf ss "$allpart", $temp,$filename;
close ss;	

## conduct the script by "system"
system ("lmp_serial  -in $scriptname" );
}

print "** Perl all done";



