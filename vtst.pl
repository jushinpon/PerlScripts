eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}' && eval 'exec perl -S $0 $argv:q' if 0;
#;-*- Perl -*-

 use Cwd;
 use FindBin qw($Bin);
 use lib "$Bin";

@ARGV==2 || die "usage: vtst.pl <file.log> <file.com>\n";

printf "This PERL code is written by Shin-Pon Ju at Emory University on 11/10/2007.\n";
printf "If there are linear molecules in this system, you should give Be, Ae, We, and Wex from experimental value.\n";


#######	analysis of com file link number.

$inputfilename1=$ARGV[1];
$inputfile1="";
open(IN,$inputfilename1);
while($_= <IN>){$inputfile1.=$_;}
close(IN);


@inputfile1=split(/-Link1-/i,$inputfile1);
$ncom = @inputfile1;
printf "The COM file number after split by -Link1- is $ncom\n";
printf "The COM files is used to get reaction coordinate from coordinate[0] \n";

for ( $i = 0; $i < $ncom; $i++ ) {
unlink "tempcom";

$nfile = $i;

open(OUT,">tempcom");

$temfile= $inputfile1[$i];

print OUT $temfile;

close(OUT);

open(IN,"tempcom");

while(<IN>){
if ( /\sF\s/i ) {
@line = split();


$num = @line;

if ($num == 4){
$coordinate[$i] = (split())[2];
}}}
close(IN);

}




###########- End of .COM analysis --######

####- Pre-process here!!!
unlink "vtstperl.inp";
open(VTSTPERL,">vtstperl.inp");

$condition = "current reaction   
Total number of structures = $ncom
Number of reactants =001
Molecules of each reactant that go to make one transition state:
  001  000  000  000  000  000  000  000 
Number of temperatures =015
Do Zero-Point Correction?;no
Include Tunneling Correction?;no
Pick one:
Results in Atmospheres; yes
Results in Bars;no
Temperatures:
1000.00
1200.00
1400.00
1600.00
1800.00
2000.00
2200.00
2300.00
2400.00
2500.00
2600.00
2700.00
2800.00
2900.00
3000.00";
printf VTSTPERL "$condition\n";
###########- End of condition -##########

$Strkey= "Structure Key:
--------------------------------------------------
 Rxn coordinate, energy(au),       species
 Molecular Wt.,Grnd.State Multiplicity, Xtd.State Mult., Excitation Energy(cm-1)
    Be,       Ae,      We,        Wex:  (This line for diatomics only)
 3 M.O.I.[au],Rot.Sym.num,Free Rot.sym.num,Free Rot.M.O.I.[au],NF,Num. of Freq. 
 Frequencies (cm-1) ; eight on a line ; leave out if monatomic.
 1 negative frequency. Only include this line if doing tunneling correction.
--------------------------------------------------
Structures:";

printf VTSTPERL "$Strkey\n";
########- End of Strkey -###########






$inputfilename=$ARGV[0];

$inputfile="";
open(IN,$inputfilename);
while($_= <IN>){$inputfile.=$_;}
close(IN);

@inputfile=split(/Entering Link/,$inputfile);
$n = @inputfile;


# caution :@inputfile[0] is useless 
printf "The log file number after split by Entering Link is $n\n NOTE: the first element is useless\n";

unlink "cor-energy.dat";
open(ENERGYDAT,">cor-energy.dat");


for ( $i = 1; $i < $n; $i++ ){

 
unlink "temp";
open(IN,">temp");
print IN $inputfile[$i];
close(IN);

open(FILE,"temp");
$nfrequency = 0;
while ( <FILE> ) {
  
# the last SCF Done is what we want
if ( /SCF Done:/ ) {$energy = (split())[4];}

###########-- End of Energy --##########
  
# Molecular mass

if ( /Molecular mass:/ ) {$mass =  (split())[2];}

#########-- End of Molecular mass --######

# the $structure should be further checked!!!!

if ( /Full point group/ ) {
    @line = split();
	$group = $line[3];
	$structure = "nonlinear";
	if ( $group =~ /\*/ ) {
		# molecule is linear 
	$structure = "linear";

	}
	if ( $group eq "KH" ) {
		# molecule is an atom
	$structure = "atom";
	}
  }
########-- End of the $structure type --#######

# Multiplicity 
 if ( /Charge/ && /Multiplicity/ ) {
	

	$degen = ( split() )[5];
	
  }
########-- End of Multiplicity --############

# moment of initial

if ( /ROTATIONAL CONSTANT/i ) {
    @line = split();
	$rot[0] = $line[3];
	$rot[1] = $line[4];
	$rot[2] = $line[5];

	$MOI1 =1804.75/$rot[0];
	$MOI2 =1804.75/$rot[1];
	$MOI3 =1804.75/$rot[2];

  } 

##############-- End of moment of initial --###########

#rotational symmetry number

if ( /ROTATIONAL SYMMETRY NUMBER/i ) {
    @line = split();
	$symno = $line[3];	
  }
############- End of rotational symmetry number -############ 
  

#Frequency

 if ( /Frequencies/ ) {
    @line = split();

	
	for ( $ii = 2; $ii < 5; $ii++ ) {
		$tt = $line[$ii];

		
		if ( $tt > 0.0 ) {
		 $nfreq=$nfrequency;		 
			$freq[$nfreq] = $tt;
			$nfrequency+=1;} 
	}
  }

##############-- End of Frequency -- ##################


}
close(FILE);
print VTSTPERL "--------------------------------\n";
printf ENERGYDAT "%8.4f %14.9f\n",$coordinate[$i-1],$energy;
printf VTSTPERL "%8.4f %14.9f %s\n",$coordinate[$i-1],$energy,$structure;
$xtd = 0; $excitener = 0;
printf VTSTPERL "%8.4f %3.1f %2.1f %2.1f\n",$mass,$degen,$xtd,$excitener;
$freerot = 0; $freerotmom = 0;$totalfre = $nfreq+1; $nf = 0;
printf VTSTPERL "%10.5f %10.5f %10.5f %2.1f %2.1f  %2.1f %d %d\n",$MOI1,$MOI2,$MOI3,$symno,$freerot,$freerotmom,$nf,$totalfre;

for ( $ifreq = 0; $ifreq < $totalfre; $ifreq++ ) {

printf VTSTPERL "%9.4f\n", $freq[$ifreq];}



}
print VTSTPERL "--------------------------------\n";

close(VTSTPERL);
close(ENERGYDAT);
 exit;
