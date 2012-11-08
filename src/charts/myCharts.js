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


// this is the 'public' function
function displayChart(tableName, chartLoc, dataLoc) {
    // okay, gotta get 'report' from somewhere
    var chartModel = new ChartModel(report, tableName);
    
    makeAndPlaceChart(chartModel, chartLoc);
}
