<?php

function getConnection() {
    $db_user = "username";
    $db_pass = "password";
    $db_name = "database";

	$con = mysql_connect("localhost", $db_user, $db_pass);  
	
	if (!$con) {
		return false;
	}
	if(!mysql_select_db($db_name, $con)) {
		return false;
	}
    return $con;
}

?>