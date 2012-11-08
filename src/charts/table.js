var Table = (function() {

// I guess each 'row' is a dict of
//   y-axis to value

//   - types?  probably ignore them.  but the data should
//     be well-typed
function Table(title, xVals, xName, yAxes, rows) {

    this.title = title;
    this.xName = xName;
    this.yAxes = yAxes;
    this.xVals = xVals;
    this.rows = rows;

    // no missing rows
    //   wait a second, is xVals a list or a dict or what?
    for(var k in xVals) {
        if(!rows[k]) {
            throw new Error("x value declared but no data found: " + k);
        }
    }
    // no extra rows
    // could also do this by counting size
    for(var k in rows) {
        if(!xVals[k]) {
            throw new Error("data found for absent x value: " + k);
        }
    }

// values can be null -- but must not be missing
    for(var k in rows) {
        var row = rows[k];
        // no missing y-axes
        for(var i = 0; i < yAxes.length; i++) {
            if(!row[yAxes[i]]) {
                throw new Error("missing value for x: " + k + ", y: " + yAxes[i]);
            }
        }
        // no extra y-axes
        for(var y in row) {
            if(yAxes doesn't have y) {
                throw new Error("unexpected value for x: " + k + ", y: " + y);
            }
        }
    }
}

// xVals :: () -> [x-value]
// title :: () -> title
// xName :: () -> x-title
// yName :: () -> y-title // not sure about this -- is this the y-scale/y-label?
// yAxes :: () -> [y-axis]
// getRow :: String -> Maybe Row :: x-value -> row     (same as below, basically)
//        :: x-value -> y-axis -> value 
Table.prototype.getRow = function(x) {
    if(this.xVals[x]) {
        return this.rows[x];
    } else {
        throw new Error("unrecognized x-value: " + x);
    }
}


return {
    'Table': Table
};

})();