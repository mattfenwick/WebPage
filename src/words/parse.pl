#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use Data::Dumper;


my ($path) = @ARGV;

open(my $file, $path) || die "couldn't open $path";

local $/; # slurp mode!

my $text = <$file>;

my @rows;
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
#        print "$cattitle     ";
        my %row = ("category" => $cattitle);
        for(my $i = 0; $i < scalar(@fields); $i++) {
            $row{$langs[$i]} = $fields[$i];
#            print "{$langs[$i] $fields[$i]}";
        }
#        print "\n";
        push(@rows, \%row);
    }
}

#print Dumper(@rows);

close($file);


putInDb();


sub putInDb {
    my ($database, $user, $password) = ("words", "wordsuser", "bonjour");
    my $dbh = DBI->connect("DBI:mysql:" . $database, 
        $user, $password, {RaiseError => 1});
        
    my %results = ();
    for my $row (@rows) {
        my %row = %$row;
        my $result = $dbh->do('insert into translations 
                    (category, english, french, italian, spanish, portuguese)
                    values(?, ?, ?, ?, ?, ?)', undef, $row{"category"}, $row{"English"},
                    $row{"French"}, $row{"Italian"}, $row{"Spanish"}, $row{"Portuguese"});
        $results{$result}++;
    }
    
    print "results: " . Dumper(\%results) . "\n";
}
