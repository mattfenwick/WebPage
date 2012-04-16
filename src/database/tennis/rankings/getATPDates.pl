#!/usr/bin/perl


use strict;
use warnings;
use LWP;
use HTML::TreeBuilder;
use Utility;


# purpose:  fetch all dates from ATP website
#	persist these dates in a database ...
#	
# it's possible that some are already in the database;
#	if so, then any additional ones should be added


&findDatesAndAddToDatabase();


sub findDatesAndAddToDatabase {
	my $dates = &findDates();
	my $rowsadded = &persistDates($dates);
	print "total rows added: $rowsadded\n";
}


sub persistDates {
	my ($dates) = @_;
	my @dates = @$dates;
	my $dbh = Utility::getDBConnection();
	my $statement = "insert into atp_date values (?, Null)";
	my $rowsadded = 0;
	my @weirddates;
	for my $date (reverse @dates) {
		# convert from ATP's dd.mm.yyyy to MySQL's yyyy.mm.dd
		$date =~ m/^(\d{2})\.(\d{2})\.(\d{4})$/;
		my ($day, $month, $year) = ($1, $2, $3);
		my $mysqldate = join("-", $year, $month, $day);
		my $result = 0;
		eval{
			$result = $dbh->do($statement, undef, $mysqldate);
		};
		if($@) {
			warn "error with <$mysqldate>: <$@>";
		} elsif($result != 1) {
			warn "strange result: <$result> for <$mysqldate>";
			push(@weirddates, $mysqldate);
		} else {
			print "result for date <$mysqldate>: <$result>\n";
		}
		$rowsadded += $result;
	}
	print "weird things happened to these dates: <@weirddates>\n";
	return $rowsadded;
}


sub findDates {
	my $root = Utility::getWebPage("http://www.atpworldtour.com/Rankings/Singles.aspx");
	my $dates = $root->find_by_attribute("name", "d");
	my @datenodes = $dates->content_list();
	my (@datelist);
	for my $k (@datenodes) {
		push(@datelist, $k->attr('value'));
	}
	$root->delete();
	return \@datelist;
}
