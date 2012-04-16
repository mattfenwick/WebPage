
use strict;
use warnings;
use Utility;


# basic plan:
#	read in all weeks (from week table) that have not yet been migrated
#	use the atpdate to look up the rankings in the `atp_rankings` table
#	for each ranking for that date found:
#		use the name to look up a playerid (hopefully the names are unique)
#		insert a new ranking, using the `monday`, playerid, rank, points, tournaments


# rankings schema
#	monday, pid, rank, points, tournaments

&migrateRankingsInDB();



sub migrateRankingsInDB {
	my $dbh = Utility::getDBConnection();
	my $weeks = &getUnmigratedWeeks($dbh);
	&copyRankings($dbh, $weeks);
}


sub getUnmigratedWeeks {
	my ($dbh) = @_;
	my $statement = "select * from week where not ismigrated";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $weeks = $sth->fetchall_arrayref({});
	return $weeks;
}


sub copyRankings {
	my ($dbh, $weeks) = @_;
	my $select = "select * from atp_rankings where date = ?";
	my $insert = "insert into ranking (monday, pid, rank, points, tournaments)
			values(?, ?, ?, ?, ?)";
	my $update = "update week set ismigrated = true where monday = ?";
	my $added = 0;
	for my $week (@$weeks) {
		print "starting monday " . $week->{'monday'} . " ........   ";
		# fetch rankings by atpdate
		my $sth = $dbh->prepare($select);
		$sth->execute($week->{'atpdate'});
		my $rankings = $sth->fetchall_arrayref({});
		$dbh->begin_work() || die "no transactions?";
		for my $ranking (@$rankings) {
			# fetch pid by last name, first name (which is unique)
			my $pid = &getPid($dbh, $ranking->{'last name'}, $ranking->{'first name'});
			my $result = $dbh->do($insert, undef, $week->{'monday'}, $pid,
				$ranking->{'rank'}, $ranking->{'points'}, $ranking->{'tournaments'});
			$added += $result;
		}
		$dbh->do($update, undef, $week->{'monday'});
		$dbh->commit();
		print "finished \n";
	}
	print "rows added: <$added>\n";
}


sub getPid {
	my ($dbh, $lname, $fname) = @_;
	my $statement = "select pid from player where lname = ? and fname = ?";
	my $sth = $dbh->prepare($statement);
	$sth->execute($lname, $fname);
	my $row = $sth->fetchrow_hashref();
	return $row->{'pid'};
}
