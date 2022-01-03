$x1 = 'abc';
$x2 = "abc";
$x3 = 1;
$x4 = 3;
for($i=1;$i<=4;$i++){
	
$temp = "x". $i; # generate x1~x4 by the loop counter "." means the combination.

print " $temp: ${$temp} \n"; #$x1~$x4
}

