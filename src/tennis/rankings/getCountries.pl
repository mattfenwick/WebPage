
use strict;
use warnings;
use Utility;

# plan:
#	get rankings page
#	get countries from page
#	check whether all data obtained from `getATPRankings.pl` refers to
#		a country in that page
#	if not, come up with a new algorithm
#	if yes, insert the country information into `tennis`.`country`

# known problems:  Zimbabwe's abbreviation is 'Rho' .... unsure why
#		Zimbabwe's expected abbr (Zim) is not in the list but there are players
#			with that abbreviation
# 		Yugoslavia doesn't appear in the list (but there are Yugoslavian players)

&getAllCountriesAndAddToDatabase();


sub getAllCountriesAndAddToDatabase {
	my $countries = &parseWebPage();
	&insertIntoDatabase($countries);
}

sub parseWebPage {
	my $url = "http://www.atpworldtour.com/Rankings/Singles.aspx";
	my $page = Utility::getWebPage($url);
	
	my @divs = $page->find_by_attribute("class", "playerBioFilterItem");
	print "number of divs: " . scalar(@divs) . "\n";
	my $countries = $divs[2];# first:  dates    second: rank pages    third: countries
	
	my @options = $countries->look_down(_tag => "option");

	my @countries;
	for my $option (@options[1 .. $#options]) {# first country is 'All Countries'
		push(@countries, {
			'abbr' => $option->{value}, 
			'name' => $option->as_text()
		});
	}
	$page->delete();
	return \@countries;
}

sub insertIntoDatabase {
	my ($countries) = @_;
	my $dbh = Utility::getDBConnection();
	my $statement = "insert into country (abbreviation, c_name) values(?, ?)";
	my $added = 0;
	
	for my $country (@$countries) {
		eval {
			my $result = $dbh->do($statement, undef, $country->{'abbr'}, 
				$country->{'name'});
			print "success for $country->{name} ($country->{abbr})! result is <$result>\n";
			$added += $result;
		} || warn "problem with $country->{name} : $@";
	}
	
	print "countries added to db: $added\n";
}
