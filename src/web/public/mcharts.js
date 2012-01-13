/**
* author:  Matt Fenwick
*
*/
function ChartModel(json, indvar, depvars) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    var rows = new Object();
    json.rows.map(function(row) {
        var key = row[indvar];
        rows[key] = row;
    });
    this.rows = rows;
    this.headers = json.headers;
    this.getRow = function(key) {
        return this.rows[key];
    }
    mydvars = new Object();
    depvars.map(function(dvar) {
        mydvars[dvar] = 1;
    });
    this.indvar = indvar;
    this.depvars = mydvars;
    this.getSeries = function(header) {
        if (header != indvar && !(mydvars[header])) {
            alert("non-existent column: " + header);
        }
        var res = new Array();
        for ( var rowkey in rows) {
            res.push(rows[rowkey][header]);
        }
        return res;
    }
}


function formatTableDOM (chartModel) {
    var key = chartModel.indvar;
    var keys = chartModel.getSeries(key);
    var mytable = document.createElement('table')
        mytable.border = 2;

    var headers = Array();
    headers.push(key);

    for (var head in chartModel.depvars) {
        headers.push(head);
    }

    var headrow = document.createElement('tr');
    for(var j = 0; j < headers.length; j++) {
        var tabhead = document.createElement('th');
        tabhead.appendChild( document.createTextNode(headers[j]) );
        headrow.appendChild(tabhead);
    }
    mytable.appendChild(headrow);

    for(var i = 0; i < keys.length; i++) {
        var row = document.createElement( 'tr' );
        var rowdata = chartModel.getRow( keys[i] );
        for(var k = 0; k < headers.length; k++) {
            var val = rowdata[headers[k]];
            if(!val) {val = '-';};
            var datum = document.createElement('td');
            datum.appendChild( document.createTextNode(val) );
            row.appendChild(datum);
        }
        mytable.appendChild(row);
    }
    return mytable;
}
    


function prepareReport(table, key, depvars, callback) {
    var xmlhttp = new XMLHttpRequest(); // assume this works
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var m = new ChartModel(JSON.parse(xmlhttp.responseText), key,
                    depvars);
            callback(m);
        } else {
            // alert('oops');
        }
    }
    xmlhttp.open("GET", "accessTable.php?table=" + table, true);
    var res = xmlhttp.send();
}

function getChart(title, location, keys, xtitle) {
    var chart = new Highcharts.Chart( {
        chart : {
            renderTo : location,
            defaultSeriesType : 'bar',
            zoomType : 'xy'
        },
        title : {
            text : title
        },
        xAxis : {
            title : {
                enabled : true,
                text : xtitle
            },
            startOnTick : false,
            endOnTick : false,
            showLastLabel : true,
            categories : keys
        },
        yAxis : {
            title : {
                text : 'Dependent variable'
            }
        },
        tooltip : {
            formatter : function() {
                return this.x + ": " + this.y;
            }
        },
        legend : {
            layout : 'vertical',
            align : 'left',
            verticalAlign : 'top',
            x : 5,
            y : 5,
            floating : false,
            backgroundColor : '#FFFFFF',
            borderWidth : 1
        },
        plotOptions : {
            scatter : {
                marker : {
                    radius : 5,
                    states : {
                        hover : {
                            enabled : true,
                            lineColor : 'rgb(100,100,100)'
                        }
                    }
                },
                states : {
                    hover : {
                        marker : {
                            enabled : false
                        }
                    }
                }
            }
        }
    });
    return chart;
}