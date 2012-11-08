
use strict;
use warnings;
use Utility;
use Data::Dumper;
use DateTime;


&linkMondays();


sub linkMondays {
	my $dbh = Utility::getDBConnection();
	my $unlinked = &getUnlinkedMondays($dbh);
	my $atpdates = &getATPRankingsDates($dbh);
	my $linked = &linkDates($unlinked, $atpdates);
	&insertIntoDatabase($dbh, $linked);
}

sub getUnlinkedMondays {
	my ($dbh) = @_;
	my $statement = "
		select 
			year(monday) as year,
			month(monday) as month, 
			day(monday) as day,
			monday
		from 
			week 
		where 
			atpdate is null";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $mondays = $sth->fetchall_arrayref({});
	return $mondays;
}

sub getATPRankingsDates {
	my ($dbh) = @_;
	my $statement = "
		select 
			year(rankingsdate) as year,
			month(rankingsdate) as month, 
			day(rankingsdate) as day,
			rankingsdate
		from 
			atp_rankings_date";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $dates = $sth->fetchall_arrayref({});
	return $dates;
}

sub linkDates {
	my ($mondays, $atps) = @_;
	my %atps;
	# for each atp date, calculate the monday and put it into %atps
	for my $atp (@$atps) {
		my $date = DateTime->new(year => $atp->{'year'}, month => $atp->{'month'},
			day => $atp->{'day'});
		while($date->day_of_week != 1) { # make it a monday
			$date->subtract(days => 1); 
		}
		if($atps{$date}) {
			die "oh shit, my assumptions failed for $date";
		} else {
			$atps{$date} = $atp;
		}
	}
	my %linked;
	# for each monday, find the latest monday that is not later than it in %atps
	for my $monday (@$mondays) {
		my $mon = DateTime->new(year => $monday->{'year'}, month => $monday->{'month'},
			day => $monday->{'day'});
		my $value;
		while(!defined($value = $atps{$mon})) {
			$mon->subtract(weeks => 1);
		}
		if($linked{$monday->{'monday'}}) {
			die "oh fuck, not good";
		} else {
			$linked{$monday->{'monday'}} = $value->{'rankingsdate'};
		}
	}
#	print Dumper(\%linked);
	return \%linked;
}

sub insertIntoDatabase {
	my ($dbh, $linked) = @_;
	my $statement = "update week set atpdate = ? where monday = ?";
	for my $monday (keys %$linked) {
		my $atpdate = $linked->{$monday};
		print "updating atpdate for <$monday> to <$atpdate> ....";
		my $result = $dbh->do($statement, undef, $atpdate, $monday);
		print "     success!: <$result>\n";
	}
	print "done";
}
