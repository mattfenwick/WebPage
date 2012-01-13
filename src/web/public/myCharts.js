// how do we import another js file?

var tables = {'tennis_age':{'key': 'whatever', 'depvars': ['a', 'b']},
              'football_team':{'key': 'a', 'depvars': []}
};


function placeChart(chartModel, chartLoc) {

}


function placeData(chartModel, dataLoc) {

}


function processReport(report, tableName, chartLoc, dataLoc) {
    var key = tables[tableName]['key'];
    var depvars = tables[tableName]['depvars'];
    var chartModel = new ChartModel(report, key, depvars);
  
    placeChart(chartModel, chartLoc);
  
    if(dataLoc) {
        placeData(chartModel, dataLoc);
	}
}


// this is the 'public' function
function displayChart(tableName, chartLoc, dataLoc) {
    var xmlhttp = new XMLHttpRequest(); // assume this works
    xmlhttp.onreadystatechange = function() { // replace this with jQuery?
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		    var json = xmlhttp.responseText;
            processReport(json, tableName, chartLoc, dataLoc);
        } else {
            alert('oops -- I really don"t know what happened');
        }
    }
    xmlhttp.open("GET", "accessTable.php?table=" + tableName, true);
    var res = xmlhttp.send();
}
