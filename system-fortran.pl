#for($i=1;$i<=100;$i++){

#$counter=sprintf("%03d",$i);
#system ("del input-$counter"); 
#system ("del output-$counter");
#}

##### should add the above code for debugging


open ss,">input.txt"; # make a file for the initial readable file
print ss "1"; # initial value
close ss;

system "DF/optimize:5 system.f"; # compile a fortran code by DOS command
# the output executable is system.exe


for($i=1;$i<=5;$i++){

$counter=sprintf("%03d",$i);	
system ("system"); #using DOS command to run the executable

open output,"<output.txt"; # read a file from the output of Fortran executable
@input=<output>;  #read data from output line by line to an array

print "the $i iteration and the value is @input\n";
close output;

system ("copy input.txt input-$counter"); #if you want to keep every input file
system ("copy output.txt output-$counter");#if you want to keep every output file

system ("del input.txt");
system ("ren output.txt input.txt");# use the output of the last iteration for the input of 
# the next iteration!!!!


}

