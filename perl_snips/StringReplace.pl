#! /usr/bin/perl -w
# my $devid;
# my @devices = `adb devices`;
# shift(@devices);
# foreach(@devices){
	# if(m/device/){
		# my @idlist = split(" ", $_);
		# $devid = $idlist[0];
		# last;
	# }
# }


# open (IN, "+< C:\\APTscripts\\APT_MTBF\\Perl\\testdriver\\opts_andr20_ffa7627.txt");
# @file = <IN>;
# seek IN,0,0;

# foreach $file (@file){
# $file =~ s/DEVICE_TYPE='.*'/DEVICE_TYPE='-s $devid'/g;
# print IN $file;
# }
# close IN;

use strict;
use warnings;
my $filename = 'opts_andr20_ffa7627.txt';
my $devID = "";
my $replace = "DEVICE_TYPE=\'\'";

my @adbdevices = `adb devices`;
shift(@adbdevices);
pop(@adbdevices);
if($adbdevices[0] =~ /device/){
	my @tokens = split(" ",$adbdevices[0]);
	$devID = $tokens[0];
}
$replace = "DEVICE_TYPE=\'-s $devID\'";
{
   local @ARGV = ($filename);
   local $^I = '.bac';
   while( <> ){
      if( s/DEVICE_TYPE='-s (.*)'/$replace/ig ) {
         print;
      }
      else {
         print;
      }
   }
}
print "Finished";