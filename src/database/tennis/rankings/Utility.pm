
use strict;
use warnings;
use DBI;
use LWP;
use HTML::TreeBuilder;


package Utility;


my $database = "tennis";
my $user = "tennisclient";
my $password = "atptennis";


sub getDBConnection {
	return DBI->connect("DBI:mysql:" . $database, 
		$user, $password, {RaiseError => 1}) 
		|| die "couldn't connect to database: $DBI::errstr";
}


sub getWebPage {
	my ($url) = @_;
	my $lwp = LWP::UserAgent->new();
	my $response = $lwp->get($url);
	my $content = $response->{_content};
	my $root = HTML::TreeBuilder->new_from_content($content);
	$root->eof();
	return $root;
}


1;