sub Nielsen_Martin {
	
use Statistics::LineFit;

$mol_num = 6.02214085774*10**(23);
$A3_m3=10**(-30);
$kpa_Gpa=10**(-6);
$cal_J = 4.184;
$real_conversion = ($cal_J*$kpa_Gpa)/($mol_num*$A3_m3);

$eV_J = 1.602176565*10**(-19);
$pa_Gpa = 10**(-9);
$metal_conversion = ($eV_J*$pa_Gpa)/$A3_m3;


#Central Finite Difference method
#https://en.wikipedia.org/wiki/Finite_difference_coefficient

@CFD =(1/280, -4/105, 1/5, -4/5, 0, 4/5, -1/5, 4/105, -1/280);## coefficients for the first derivative


foreach $temp_fold (@subdir){	        
  
  @temp_sol=();
  
  open solid, "<./$temp_fold/solid.dat";
  @temp_sol=<solid>; ###A**3
  close solid;
    
  @temp_ene=();
  @strain = ();
  open strenergy, "<./$temp_fold/Strain_Energy.dat";  
  @temp_ene=<strenergy>;
  close strenergy; 
  
  $strain_num = @temp_ene; 
 # for($ise=0;$ise<$strain_num;$ise++){
 #        @temp= split('\s+',$temp_ene1[$ise]);
 #        @temp_ene[$ise]= $temp[3];
 #        $strain[$ise]= $temp[1];                
 #     }   
  
  #Assigning the first four values for numerical derivative
  @cfd_ene = (); 
## The energy should be symmetric for small compression and tension  
      for($ic=0;$ic<=3;$ic++){
         @temp= split('\s+',$temp_ene[4-$ic]);
         $cfd_ene[$ic]=$temp[3];         
      }
  
      for($ic=4;$ic< $strain_num+4;$ic++){
         @temp= split('\s+',$temp_ene[$ic-4]);
         $cfd_ene[$ic]=$temp[3];          
      }
  
  ##derivative interval, could put it outside the largest loop
     @temp1= split('\s+',$temp_ene[0]);
     @temp2= split('\s+',$temp_ene[1]);
     $cfd_int = $temp2[1]-$temp1[1];
     #print "$cfd_int";
   
  
  ## get the stress at each strain (total strain number(from lammps) minus 4)
   @vol=();
   open vol, "<./$temp_fold/solid.dat";
   @vol=<vol>;
   close vol;
   unlink "./$temp_fold/SS_curve.dat";
   open stress, ">./$temp_fold/SS_curve.dat";
     for($id=0;$id< $strain_num-4;$id++){
     	   
       $sum = 0.0;
     	   for($icof=0;$icof<9;$icof++){
           $sum = $sum+ $cfd_ene[$id+$icof]*$CFD[$icof];            
         }
        
        if($units eq "real"){
           $stress = $real_conversion*($sum/$cfd_int)/($vol[$id]);
           }
           elsif($units eq "metal"){
           	$stress = $metal_conversion*($sum/$cfd_int)/$vol[$id];
           	};
      
        @temp= split('\s+',$temp_ene[$id]);
        #print  "$temp[0] $stress sum: $sum  int:$cfd_int vol:$vol[$id]\n";
        print stress  "$temp[1] $stress\n";
        # J=kg.m**2/s**2; N*m; Pa*m**3
        # 1 Kcal = 4.184 KJ (by lammps) 
      }
   close stress;  
}

#####Getting Young's modulus for strain lower than 0.02
unlink "T_Young_modulus.dat"; 
open TY, ">T_Young_modulus.dat";

foreach  $temp_fold (@subdir){	       
  
  @ss=();  
  open ssc, "<./$temp_fold/SS_curve.dat";
  @ss=<ssc>; ###A**3
  close ssc;
  $ss_num=@ss;
  @xValues = ();
  @yValues = ();
     for($j=0;$j<$ss_num;$j++){	
       @temp= split('\s+',$ss[$j]);
       if($temp[0] <= 0.02){
       	push @xValues, $temp[0];
       	push @yValues, $temp[1];
       	};
     };
$lineFit = Statistics::LineFit->new();
$lineFit->setData (\@xValues, \@yValues) or die "Invalid data";
($intercept, $slope) = $lineFit->coefficients();
print TY "$temp_fold $slope\n";
}

close TY;
}
1;