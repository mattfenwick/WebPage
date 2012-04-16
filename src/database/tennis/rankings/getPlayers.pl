
use strict;
use warnings;
use Utility;
use Data::Dumper;


&getPlayersAndAddToDatabase();


sub getPlayersAndAddToDatabase {
	my $dbh = Utility::getDBConnection();
	my $players = &getPlayers($dbh);
	&insertIntoDatabase($dbh, $players);
}


sub getPlayers {
	my ($dbh) = @_;
	my $statement = "select distinct `last name`, `first name`, nationality from atp_rankings";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $rows = $sth->fetchall_arrayref({});
#	print "\nplayers: " . Dumper($rows) . "\n\n\n";
	return $rows;
}


sub insertIntoDatabase {
	my ($dbh, $players) = @_;
	my $statement = "insert into player (fname, lname, country) values(?, ?, ?)";
	my $added = 0;
	
	my @failed;
	
	for my $player (@$players) {
		eval {
			print "trying player " . $player->{'last name'} . " ....";
			my $result = $dbh->do($statement, undef, $player->{'first name'}, 
				$player->{'last name'}, $player->{'nationality'});
			$added += $result;
			print "success!!\n";
		};
		if ($@) {
			warn "problem with " . $player->{'last name'} . $player->{nationality} . ": $@";
			push(@failed, $player);
		}
	}
	
#	print "players that could not be added:  " . Dumper(\@failed) . "\n\n";
	print "\n\nnumber of players added:  $added\n";
}