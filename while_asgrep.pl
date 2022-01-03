open ss,"<log.lammps";
open ss11,">MC_Energy.dat";
$i=0;
while(<ss>){
#  if ( /^elast :/i ) {
 if ($_ =~ /^elast :/i ){
  	$i=$i+1;
	  @energy = " ";
    @energy=split(/\s+/,$_);
    printf ss11 "%d %8.3f \n",$i,$energy[4];
    }	
}
close ss;
close ss11;
