
use strict;
use warnings;
use Utility;
use Log::Log4perl qw(:easy);
use Data::Dumper;


BEGIN {
    Log::Log4perl->easy_init({
        level   => $DEBUG,
        file    => ">getAtpRankingsLog.txt",
        layout  => '%p  %F{1}-%L-%M: (%d) %m%n' 
    });
}


# basic plan
#	1. grab all of those atpdates that have not been checked
#	2. check them for rankings
#	3. write results of (2) to atp_date (update column `numberofrankings` to #)
#	4. if result of (2) is yes:
#		add date to `atp_rankings_date`
#		insert rankings into `atprankings`


&getNewRankingsAndAddToDatabase();


sub getNewRankingsAndAddToDatabase {
	my $dbh = Utility::getDBConnection();
	# get list of unchecked
	my $unchecked = &getUncheckedRankings($dbh);
	
	my (@no, @yes, @noDownload);
	
	for my $datehash (@$unchecked) {
		my $date = $datehash->{'atpdate'};
		print "working on date <$date>\n";
		my ($year, $month, $day) = ($datehash->{year}, $datehash->{month}, $datehash->{day});
		my $rankings = &getRankingsPage($year, $month, $day);
		
		if(!$rankings) { # if couldn't download the web page: skip to next
			push(@noDownload, $date);
			next;
		}
		my @rankings = @$rankings;
		my $statement = "update atp_date set numberofrankings = ? where atpdate = ?";
		my $number = scalar(@rankings);
		if($number > 0) { # wheeee there are rankings
			push(@yes, $date);
			eval {
				my ($num, $dat, @ins);
				$dbh->begin_work() || die "no transactions?";
				$num = $dbh->do($statement, undef, $number, $date); # let the db know how many rankings there are for the date
				# error checking
				my $datestatement = "insert into atp_rankings_date values (?)"; # insert the date into `atp_rankings_date`
				$dat = $dbh->do($datestatement, undef, $date);
				# error checking
				my $insertstatement = "insert into atp_rankings values (?, ?, ?, ?, ?, ?, ?)";
				for my $ranks (@rankings) {
					my $ins = $dbh->do($insertstatement, undef, 
						$date, $ranks->{'last name'}, $ranks->{'first name'}, $ranks->{'rank'}, 
						$ranks->{'nationality'}, $ranks->{'points'}, $ranks->{'tournaments'});
					push(@ins, $ins);
					# error checking
				}
				$dbh->commit();
				print "results: <$num> <$dat> <@ins>\n";
			} || die "transaction failed for date <$date>:  <<<<$@>>>>";
		} else { # nope, no rankings on this page
			push(@no, $date);
			$dbh->do($statement, undef, 0, $date); # let the db know: 0 rankings for the date
			# error checking
		}
		print "finished date <$date>\n";
		sleep(2);
	}
	return {
		'not downloaded' => \@noDownload,
		'have rankings' => \@yes,
		'do not have rankings' => \@no
	};
}


sub getUncheckedRankings {
	my ($dbh) = @_;
	my $statement = "select *, year(atpdate) as `year`, month(atpdate) as `month`, 
		day(atpdate) as `day`  from atp_date where numberofrankings is null";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $rows = $sth->fetchall_arrayref({});# pass in hashref to get arrayref to hashrefs
	return $rows;
}


sub getRankingsPage {
	my ($year, $month, $day) = @_;
	my $urlstart = "http://www.atpworldtour.com/Rankings/Singles.aspx?d=";
	my $urlend = "&c=&r=1#";
	# ATP does dates in `dd.mm.yyyy` format
	# it's critical to add leading 0 to day and month to make them two characters
	#	otherwise the site will serve up the most recent rankings page
	if ($month < 10) {$month = '0' . $month};
	if ($day < 10) {$day = '0' . $day};
	my $atpdate = join(".", $day, $month, $year);
	my $url = join("", $urlstart, $atpdate, $urlend);
	print "using date <$atpdate> to grab url <$url> from atptennis.com\n";
	my $rankings_page = Utility::getWebPage($url);
	if(!$rankings_page) {
		return undef;
	} else {
		my $parsed = &parse_rankings($rankings_page);
		$rankings_page->delete();
		return $parsed;
	}
}


sub parse_rankings {    #HTML::TreeBuilder
	my ($root)       = @_;
	my @playersdiv =
	  $root->find_by_attribute( "class", "bioTableWrap bioTableWrapAlt" );

	my @trs = $playersdiv[0]->look_down( _tag => "tr" );
	my @rows;
	for my $tr (@trs[1..$#trs]) { # skip the first row:  it's the headers
		push(@rows, &parsePlayerRow($tr));
	}
		
	return \@rows; # returns ref to empty list if no rankings rows
}


# rank, name and country now together
sub parsePlayerRow {
    my ($tr) = @_;
    my %row;
    my @data = $tr->look_down( _tag => "td" );
    
#    DEBUG("player data: ");
#    for my $d (@data) {
#        DEBUG("as text: " . $d->as_text());
#    }
    
#    $row{'rank'} = $data[ 0 ]->as_text();
    
    my $rankNameAndNation = $data[0]->as_text();#rank, name and nationality
    $rankNameAndNation =~ s/\((.*?)\)//;# remove country--$1 is set to 3-letter abbr
    $row{'nationality'} = $1;
#   print "name before cleaning: $nameAndNation\n";
    # remove rank
    #   also remove whitespace after rank (but don't save the whitespace)
    $rankNameAndNation =~ s/^(\d+)\s//;
    $row{'rank'} = $1;
    $rankNameAndNation =~ s/[^\w,-\. ]//g;# remove weird symbols but not letters, commas, periods, -'s, spaces
#   print "name after cleaning: $nameAndNation\n";
    # EDIT:  is the previous line necessary?  does that really happen?
    my @names = split( ',', $rankNameAndNation );    #name was in format 'last,first'
    $row{'last name'} = $names[0];
    $row{'first name'} = $names[1];

    my $points = $data[ 1 ]->as_text();
    $points =~ s/,//g; # remove commas (as in 10,230)
    $row{'points'} = $points;
    
    $row{'change'} = $data[ 2 ]->as_text();
    
    $row{'tournaments'} = $data[ 3 ]->as_text();
    
    INFO("row: " . Dumper(\%row));
    
    return \%row;
}



sub oldParsePlayerRow {
	my ($tr) = @_;
	my %row;
	my @data = $tr->look_down( _tag => "td" );
	
	DEBUG("player data: ");
	for my $d (@data) {
	    DEBUG("as text: " . $d->as_text());
	}
	
	$row{'rank'} = $data[ 0 ]->as_text();
	
	my $nameAndNation = $data[ 1 ]->as_text();#name and nationality together in one element
	$nameAndNation =~ s/\((.*?)\)//;# remove country--$1 is set to 3-letter abbr
	$row{'nationality'} = $1;
#	print "name before cleaning: $nameAndNation\n";
	$nameAndNation =~ s/[^\w,-\. ]//g;# remove weird symbols but not letters, commas, periods, -'s, spaces
#	print "name after cleaning: $nameAndNation\n";
	# EDIT:  is the previous line necessary?  does that really happen?
	my @names = split( ',', $nameAndNation );    #name was in format 'last,first'
	$row{'last name'} = $names[0];
	$row{'first name'} = $names[1];

	my $points = $data[ 2 ]->as_text();
	$points =~ s/,//g; # remove commas (as in 10,230)
	$row{'points'} = $points;
	
	$row{'change'} = $data[ 3 ]->as_text();
	
	$row{'tournaments'} = $data[ 4 ]->as_text();
	
	return \%row;
}
