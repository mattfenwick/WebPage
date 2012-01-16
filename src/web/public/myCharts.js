// how do we import another js file?

// for independent variable:  1) db column name, 2) display name
// for dependent variables:   1) db column name, 2) display name, 3) type

var tables = {
    brand: {
        chartType: 'bar',
        title:     'Gas brand',
        indVar:  ['brand', 'brand'],
        depVars: [['fillups',          'number of fillups',          parseInt   ], 
                  ['average price',    'average price per gallon',   parseFloat ], 
                  ['average gallons',  'average gallons per fillup', parseFloat ], 
                  ['total gallons',    'total gallons',              parseFloat ]]
    },
    
    tank: {
        chartType: 'bar',
        title:     'Gas tank',
        indVar:  ['tank number', 'tank number'],
        depVars: [['gallons',           'gallons',                 parseFloat ],
                  ['price per gallon',  'price per gallon',        parseFloat ],
                  ['miles',             'miles',                   parseInt   ],
                  ['miles per gallon',  'miles per gallon',        parseFloat ],
                  ['days',              'days since last fill-up', parseInt   ],
                  ['mileage',           'total mileage',           parseInt   ]]
    },
    
    tennisage: {
        chartType: 'bar',
        title:     'Tennis rankings by age',
        indVar:  ['age', 'age'],
        depVars: [['count_youngest',  'number with youngest ranking',  parseInt],
                  ['count_oldest',    'number with oldest ranking',    parseInt],
                  ['total_rankings',  'total number of rankings',      parseInt]]
    },
    
    tennisrank: {
        chartType: 'bar',
        title:     'Tennis rankings by rank',
        indVar:   ['rank', 'rank'],
        depVars:  [['maximum age',        'oldest player',       parseInt],
                   ['minimum age',        'youngest player',     parseInt],
                   ['average age',        'average player age',  parseFloat],
                   ['standard deviation of age', 'std dev of player age', parseFloat],
                   ['number of players',  'number of players',   parseInt]]
    },
    
    bcsyear: {
        chartType: 'bar',
        title:     'BCS bowl games, by year',
        indVar:   ['year', 'year'],
        depVars:  [["points, winner",  "average points, winner",     parseFloat],
                   ["points, loser",   "average points, loser",      parseFloat],
                   ["margin",          "average margin of victory",  parseFloat],
                   ["total points",    "average total points",       parseFloat]]
    },
    
    bcsconf: {
        chartType: 'bar',
        title:     'BCS bowl games, by conference',
        indVar:    ['conf', 'conference'],
        depVars:   [["appearances",     "appearances",             parseInt],
                    ["wins",            "wins",                    parseInt],
                    ["losses",          "losses",                  parseInt],
                    ["points scored",   "average points scored",   parseFloat],
                    ["points given up", "average points given up", parseFloat],
                    ["teams",           "qualifying teams",        parseInt]]
    },
    
    bcsteam: {
        chartType: 'bar',
        title:     'BCS bowl games, by school',
        indVar:    ['name', 'school'],
        depVars:   [["appearances",     "appearances",             parseInt],
                    ["wins",            "wins",                    parseInt],
                    ["losses",          "losses",                  parseInt]]
    },
    
    bcsrank: {
        chartType: 'bar',
        title:     'BCS bowl games, by BCS rank',
        indVar:    ['rank', 'BCS rank'],
        depVars:   [["appearances",     "appearances",             parseInt],
                    ["wins",            "wins",                    parseInt],
                    ["losses",          "losses",                  parseInt]]
    }
};



function ChartModel(json, tableName) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    // also get chart title, x title
    
    var entry = tables[tableName];
    var key = entry.indVar[0];
    this.indvar = {
            name: entry.indVar[1],
            values: json.rows.map(function(row) {return row[key];} )
    };
    
    this.depvars = [];
    for(var i = 0; i < entry.depVars.length; i++) {
        var eDepvar = entry.depVars[i];
        
        var dbname = eDepvar[0];
        var colname = eDepvar[1];
        var parseFunc = eDepvar[2];
        
        this.depvars.push({
            name:   colname,
            values: json.rows.map(
                function(row) {
                    var value = parseFunc(row[dbname]);
                    if(isNaN(value)) {
                        return 0;
                    } else {
                        return value;
                    }
                }) 
        });
    };
    
    this.title = entry.title;
    // do we need to save the type?  
}


function makeAndPlaceChart(chartModel, location) {
    // previously parameters:  title, indvarVals, xtitle
    var chart = new Highcharts.Chart( {
        chart : {
            renderTo : location,
            defaultSeriesType : 'bar',
            zoomType : 'xy'
        },
        title : {
            text : chartModel.title       // chart title
        },
        xAxis : {
            title : {
                enabled : true,
                text : chartModel.indvar.name  // x label
            },
            startOnTick : false,
            endOnTick : false,
            showLastLabel : true,
            categories : chartModel.indvar.values  // x series
        },
        yAxis : {
            title : {
                text : 'Dependent variable'
            }
        },
        tooltip : {
            formatter : function() {
                return chartModel.indvar.name + ": " + this.x + 
                   "<br/>" + this.series.name + ": " + this.y;
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
    //
    for(var i = 0; i < chartModel.depvars.length; i++) {
        var depvar = chartModel.depvars[i];
        
        var userlabel = depvar.name;
        var vals = depvar.values;
        
        chart.addSeries({
            name:  userlabel,
            data:  vals
        });
    };
    //  it's probably not necessary to return the chart
    return chart;
}


function placeData(chartModel, dataLoc) {
    // not implemented
}


function processReport(report, tableName, chartLoc, dataLoc) {
    var chartModel = new ChartModel(report, tableName);
    
    makeAndPlaceChart(chartModel, chartLoc);
  
    if(dataLoc) {
        placeData(chartModel, dataLoc);
    }
}


// this is the 'public' function
function displayChart(tableName, chartLoc, dataLoc) {
    var xmlhttp = new XMLHttpRequest(); // assume this works
    xmlhttp.onreadystatechange = function() { // replace this with jQuery?
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var json = JSON.parse(xmlhttp.responseText);
            processReport(json, tableName, chartLoc, dataLoc);
        } else {
            //alert("oops -- I really don't know what happened");
        }
    };
    xmlhttp.open("GET", "accessTable.php?table=" + tableName, true);
    var res = xmlhttp.send();
}
