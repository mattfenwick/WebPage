
use warnings;
use Utility;
use Data::Dumper;
use strict;

my $PREFIX = "http://www.atpworldtour.com/Tennis/Players/";
my $SUFFIX = ".aspx";

die "unaddressed issue:  there are nulls in the atp data, but this doesn't account for them";

&getPlayerInformation();

sub getPlayerInformation {
	my $dbh       = Utility::getDBConnection();
	my $statement = "select pid, lname, fname from player 
		where dateofbirth is null order by -pid";
	my $sth = $dbh->prepare($statement);
	$sth->execute();
	my $rows = $sth->fetchall_arrayref( {} );    # is this right?
	my $updated = 0;
	for my $row (@$rows) {
		my ( $lname, $fname ) = ( $row->{lname}, $row->{fname} );
		my ( $topName, $otherName ) = (
			&getTopNamePart( $lname, $fname ),
			&getOtherNamePart( $lname, $fname )
		);
		my $topURL   = join( "", $PREFIX, $topName,   $SUFFIX );
		my $otherURL = join( "", $PREFIX, $otherName, $SUFFIX );

		# get top page
		my $page = Utility::getWebPage($topURL);
		my $info;
		eval { $info = &parsePage( $row, $page ); };
		if ($@) {

			#warn "$topURL failed";
			eval {
				$page = Utility::getWebPage($otherURL);
				$info = parsePage( $row, $page );
			};    # || warn "$otherURL failed";
		}
		if ($info) {
			print "page found for <$fname $lname>\n";
			print Dumper($info);    # only if one of the pages worked
			my $result = &insertInfo( $dbh, $info );
			print "result: $result\n";
			$updated++;
		}
		sleep(2);
	}
	print "<$updated> rows updated\n";

}

sub parsePage {
	my ( $row, $page ) = @_;

	#        print "trying ul ....\n";
	my @uls =
	  $page->find_by_attribute( "id", "playerBioInfoList" );    # is this right?
	my $ul = $uls[0];

	#        print "trying li's ....\n";
	my @lis = $ul->look_down( _tag => "li" );
	my %fields;
	for my $li (@lis) {

		#      	        print "trying spans ....\n";
		my @list = $li->content_list;
		my $key  = $list[0]->as_text;
		chop($key);
		my $value =
		  $list[1];    # value is in text node after span (has leading space)

		#      	        print "key: $key\n";
		$fields{$key} = $value;

		# probably want DOB, height, weight, left/right, turned pro
	}
	my ($tage) = $fields{Age};    # ` 19 (07.05.1992)`
	my $dob;
	if($tage =~ /(\d{2})\.(\d{2})\.(\d{4})/) {
		$dob = join( "-", $3, $2, $1 );
	} else {
		$fields{Birthdate} =~ /(\d{2})\.(\d{2})\.(\d{4})/;
		$dob = join( "-", $3, $2, $1 );
	}
	my ($theight) = $fields{Height};    # 6' (183 cm)
	my $height;
	if($theight =~ /\((\d+) cm\)/) {
		$height = $1;
	}
	my $weight;
	if($fields{Weight} =~ /\((\d+) kg\)/) {    #  160 lbs (73 kg)
		$weight = $1;
	}
	my $lefty;

	if ( $fields{Plays} =~ /Right/ ) {    # Right-handed
		$lefty = 0;
	}
	elsif ( $fields{Plays} =~ /Left/ ) {
		$lefty = 1;
	}
	else {
		warn "what did we get?  $fields{Plays}";
	}
	return {
		'dateofbirth' => $dob,
		'islefty'     => $lefty,
		'height'      => $height,
		'weight'      => $weight,
		'pid'         => $row->{'pid'}
	};
}

sub insertInfo {
	my ( $dbh, $row ) = @_;
	my $statement = "update player set dateofbirth = ?, height_cm = ?, 
		weight_kg = ?, islefty = ? where pid = ?";
	my $result =
	  $dbh->do( $statement, undef, $row->{'dateofbirth'}, $row->{'height'},
		$row->{'weight'}, $row->{'islefty'}, $row->{'pid'} );
	return $result;
}

sub getTopNamePart
{   # http://www.atpworldtour.com/Tennis/Players/Top-Players/Arnaud-Clement.aspx
	my ( $lname, $fname ) = @_;
	$lname =~ s/ /-/g;
	$fname =~ s/ /-/g;
	my @list = ( 'Top-Players', $fname . "-" . $lname );
	return join( "/", @list );
}

sub getOtherNamePart
{    # http://www.atpworldtour.com/Tennis/Players/Mi/V/Vincent-Millot.aspx
	my ( $lname, $fname ) = @_;
	my ( $firstFirst, $lastFirstTwo );
	if ( $fname =~ m/^([A-Z])/ ) {
		$firstFirst = $1;
	}
	else {
		warn "name <$fname> didn't work";
	}
	if ( $lname =~ m/^([A-Z][a-z])/ ) {
		$lastFirstTwo = $1;
	}
	else {
		warn "name <$lname> didn't work";
	}
	$lname =~ s/ /-/g;
	$fname =~ s/ /-/g;
	return join( "/", $lastFirstTwo, $firstFirst, $fname . "-" . $lname );
}

