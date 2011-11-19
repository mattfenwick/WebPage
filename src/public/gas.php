<?php

include_once('../first.php');


function getReport($user_table) {
	$tables = array(
                  "tank"       => "p_tank", 
                  "month"      => "p_month", 
                  "aggs"       => "p_aggregates",
                  "brand"      => "p_brand", 
                  "fillup"     => "p_full_report",
                  "tennisage"  => "tennis_byage",
                  "tennisrank" => "tennis_byrank"
      );
	
      $con = getConnection();
	
	$table = $tables[$user_table];
	
	if(!$table) {
		die(json_encode(array("error" => "bad table name")));
	}
	
	$query = "select * from " . $table;
	$res = mysql_query($query, $con);
	
	if(!$res) {
		die(json_encode(array("error" => "no results from table")));
	}
				
	$fields_num = mysql_num_fields($res);
	$fields = array();
	for($i=0; $i < $fields_num; $i++) {
		$field = mysql_fetch_field($res);
		$fields[$i] = $field->name;
	}
	
	$i = 0;
	while($row = mysql_fetch_array($res)) {
		$rows[$i] = $row; #
		$i++; #  
	}
	$json = array("rows" => $rows, "headers" => $fields);
	
	$jsontext = json_encode($json);
	return $jsontext;
}

?>