##1. md XX: make XX folder (directory)
##2. rd XX: remove XX folder (directory)
#(doesn't work if there is any file in the folder)
##3. move XX ff: move XX to the subfolder ff
##4. del /Q XX: del all files in the subfolder XX
##5. copy xx ff: copy xx to be ff 
##6. rename (or ren) xx ff: rename xx to be ff 
## 7. del XX: remove XX file

##Please try to do (first try one by DOS window directly)
## 1. make empty files 001 to 100 (.dat file)
## 2. make folders 001 to 100
## 3. copy 001.dat as DOS001.dat
## 4. rename 001.dat as 001DOS.dat
## 5. remove 001DOS.dat
## 6. move DOS001.dat to subfolder 001
## 7. remove all files in subfolder 001
## 8. remove all subfolder


for($i=1;$i<=100;$i++){
$count=sprintf("%03d",$i);
# open files
open ss,">$count.dat";
close ss;	
#system ("md  $count"); #using DOS command
#mkdir $count; # using Perl default command 
#rmdir  $count; # using Perl default command
}

#for($i=1;$i<=100;$i++){
#$count=sprintf("%03d",$i);	
#system ("rd  $count");
#}