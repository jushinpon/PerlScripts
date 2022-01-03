##This Perl script is to convert the data files into molecule files and a parameter file.
## Developed by Prof. Shin-Pon Ju at NSYSU on Dec. 9 2015.


@datafiles= ("polypvdf_1_50_1.lmp");

### bulid a hash for element-> key is the atomic mass (1.007970) and the value is atomic symbol(H) 

####




  open ss,"<$datafiles[0]";
  $temp = "moltemp"; ### combine letters by "." operator

  open ss11,">$temp";
  
  
  $allpart = ""; #put all lines into this scalar
  
   while(<ss>){
   	   $allpart.=$_;
   	
	
##################################	
      if ($_ =~ /atom types/ ){      	    	
	        $_=~s/^\s+//g; # remove the begining space 
          @temp=split(/\s+/,$_);
          printf ss11 "   %d atom types\n",$temp[0];
          $atomtypes = $temp[0];#keep the information about atom number
         }	
	
##################################
   }

#############get parameters here

      @Masses = split(/Masses/,$allpart);
      print "$Masses[0]";
      print "this is\n $Masses[1]\n test";
      @Masses1 = split(/\n/,$Masses[1]);
      print "$Masses1[0] $Masses1[1] $Masses1[2] $Masses1[3]";
        ## for(){}
      
########      
      

##############
 close ss;
 close ss11;

##Please print the atomic mass and the corresponding symbols into a file