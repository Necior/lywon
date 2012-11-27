#!/usr/bin/env perl
$|++;
use strict;
use warnings;

sub clear {
	print "\033[2J";
	print "\033[0;0H";
}

open(DB, "<", $ARGV[0]);
my @db1;
my @db2;
while(<DB>){
	if(($_ eq "") || ($_ eq "\n")) {
		
	}
	else {
		my @tmp = split(/\t/);
		chomp($tmp[0]);
		chomp($tmp[1]);
		push(@db2, $tmp[0]);
		push(@db1, $tmp[1]);
	}
}
close(DB);
my $success = 0;
my $fails = 0;
my $tog = 0;
while(1) {
	my $random = rand($#db1 + 1);
	print $db1[$random] . "\n$tog\t\t ";
	my $out = <STDIN>;
	chomp($out);
	if($out eq ";;;") {
		print $success/($tog)*100 . "% correct\n" . 'Total answers: ' . int($tog) . "\n";
		exit;
	}
	$tog++;
	if($out eq $db2[$random]) {
		$success++;
	}
	else {
		$fails++;
		print "FAIL!\n\t\t$db2[$random]";
		sleep(3);
	}
	&clear;
}
