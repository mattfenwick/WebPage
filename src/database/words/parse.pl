#!/usr/bin/perl

use strict;
use warnings;

my ($path) = @ARGV;

open(my $file, $path) || die "couldn't open $path";

local $/; # slurp mode!

my $text = <$file>;

my @categories = split("\n\n", $text);

for my $category (@categories) {
	my @lines = split("\n", $category);
	my $cattitle = shift @lines;
	my $langs = shift @lines;
	my @langs = split("\t", $langs);
	print "category: <$cattitle>    ";
	print "langs: <$langs> " . scalar(@langs) . "\n";
	for my $line (@lines) {
		my @fields = split("\t", $line);
		if(scalar(@fields) != scalar(@langs)) {
			print "oh fuck: <" . join("<>", @fields) . "> <@langs>"; die;
		}
		print "$cattitle     ";
		for(my $i = 0; $i < scalar(@fields); $i++) {
			print "{$langs[$i] $fields[$i]}";
		}
		print "\n";
	}
}

close($file);