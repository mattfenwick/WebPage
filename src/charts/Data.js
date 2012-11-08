var Data = (function(Table) {

// title, xvals, xname, yaxes, rows
// another way to do this would be:
// title, xname, yaxes, rows (xvals can be obtained using 'xname')
var brand = Table.Table(
    'Gas brand',
    'brand',
    ['# of fillups', 'average price per gallon', 'average gallons per fillup', 'total gallons'],
    ... some data ...
);

var tank = Table.Table(
    'Gas tank',
    'tank number',
    ['gallons', 'price per gallon', 'miles', 'MPG', 'days since last fill-up', 'total mileage'],
    ... some data ...
);

return {
    'brand': brand,
    'tank':  tank
};

})(Table);
