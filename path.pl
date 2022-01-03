use Cwd 'abs_path';
$temp_path=abs_path($0);## use this to get the path
print "current path : $temp_path \n";
print "\$0 is $0 \n";
$slash="\\"."\\"."$0"; ##note if you want to use "\" in the variable, you should use "\\" for gettting "\".
print "\$slash is $slash \n";
$temp_path =~s/$slash//g;
print "***** Current path $temp_path*****\n";


#system ('rmdir /s/q test');
#system "mkdir test";
#$cp_pathexe ="$temp_path"."\\$temp_fold"."\\Getvol.exe";

#Quiz:1. open 100 directories and make a file with an integer in each directory by "open".
#     2. read them and add 1 for the integer in each directory


#open solid, "<./test/solid.dat";
#  @temp_sol=<solid>; 
#  close solid;

# unlink "./$temp_fold/SS_curve.dat";
