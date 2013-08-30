#!/usr/local/bin/perl
use Data::Dumper;

open(myfile,"C:\\Users\\c_kmahen\\Documents\\1.txt") || die (" Can't open the file"); 
my $iter = 1;
my %wordCount = ();
while ($inputline = <myfile>) {
	@arr = split(" ", $inputline);
	foreach $word (@arr){
		if($word =~ /(^[A-Z].*)/){
			$wordCount{$1}++;
		}
	}
}

while ( my ($key, $value) = each(%wordCount) ) {
	print "wordCount[$key] => $value\n";
}