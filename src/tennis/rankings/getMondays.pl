
use strict;
use warnings;
use Utility;
use Data::Dumper;
use DateTime;


my $date = DateTime->today();

while($date->day_of_week != 1) {
	$date->subtract(days => 1); 
}

my $dbh = Utility::getDBConnection();

my $statement = "insert into week values(?, null, 0)";

# terminates when it encounters a database error, which it should
#	due to primary key constraints
while(1) {
	die unless $date->day_of_week == 1;
	my $monday = join("-", $date->year, $date->month, $date->day);
	print "monday: $monday ..... ";
	$dbh->do($statement, undef, $monday);
	print "success\n";
	$date->subtract(weeks => 1);
}
