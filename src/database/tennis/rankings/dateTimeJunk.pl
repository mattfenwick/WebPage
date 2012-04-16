
use strict;
use warnings;
use Utility;
use Data::Dumper;
use DateTime;


my $today = DateTime->today();

print "today: $today\n";

my $dow = $today->day_of_week();

print "day of week: $dow\n";

my $first = DateTime->new(
	year => 1973,
	month => 8,
	day => 20
);

print "day of week for $first: " . $first->day_of_week . "\n";

my $dbh = Utility::getDBConnection();

my $statement = "select year(atpdate) as `year`, month(atpdate) as `month`, 
	day(atpdate) as `day` from atp_date";

my $sth = $dbh->prepare($statement);

$sth->execute();

my $dates = $sth->fetchall_arrayref({});

my %dsow;
for my $date (@$dates) {
	my $dt = DateTime->new(year => $date->{'year'}, month => $date->{'month'},
		day => $date->{'day'});
	my $dayow = $dt->day_of_week;
	if ($dayow != 1) {
		print "$dayow $dt\n";	
	} else {
		$dsow{$dayow} += 1;
	}
}

print "days of week: " . Dumper(\%dsow) . "\n";