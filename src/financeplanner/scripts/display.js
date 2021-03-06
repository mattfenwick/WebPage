
var Display = (function($, _) {
"use strict";

function GridView(analysis) {
  if (!(this instanceof GridView)) {
    throw {
        'type': 'constructor',
        'message': 'GridView Constructor called as a function'
    };
  }
  var self = this;
  analysis.bind('setActiveCashFlow', function(data) {
    self.setCashFlow(analysis.getCashFlow(data.name));
  });
  this.cashFlow = null;
}

GridView.prototype.setCashFlow = function(cashFlow) { 
  this.undisplay();
  this.cashFlow = cashFlow;
  var self = this;
    
  cashFlow.bind('addPerTran', function(data) {
    var id, perTran;
    id = data.id;
    perTran = cashFlow.getPerTran(id);
    self.makeRow(id, perTran);
  });
  this.display();
};

GridView.prototype.display = function() {
    // build new stuff
    //    add listeners
    //    create HTML
    var perTrans = this.cashFlow.getPerTrans(),
        id;
    for(id in perTrans) {
        this.makeRow(id, perTrans[id]);
    }
};

GridView.prototype.undisplay = function() {
    // get rid of old cashflow:
    //    remove listeners
    //    clear HTML
    //    check for unsaved work? 
    if(this.cashFlow) {
      this.cashFlow.unbind('addPerTran');
    }
    $('#pertrans .ptranrow').remove();
};

GridView.prototype.setRowValues = function(perTran, sel) {
    $(sel + ' .amount'     ).val(perTran.amount     );
    $(sel + ' .description').val(perTran.description);
    $(sel + ' .period'     ).val(perTran.period     );
    $(sel + ' .type'       ).val(perTran.type       );
};

GridView.prototype.makeRow = function(id, perTran) {
    var self = this,
        idsel = '#' + id,
        rowHTML = [
     '<tr class="ptranrow" id="' + _.escape(id) + '">',
      '<td>',
       '<button class="deletepertran">Delete</button>',
      '</td>',

      '<td>',
       '<input type="text" class="amount inputfield" />',
      '</td>',

      '<td>',
       '<input type="text" class="description inputfield">',
      '</td>',
 
      '<td>',
       '<select class="period inputfield">',
          '<option value="month">month</option>',
          '<option value="year">year</option>',
        '</select>',
      '</td>',

      '<td>',
       '<select class="type inputfield">',
          '<option value="credit">credit</option>',
          '<option value="debit">debit</option>',
        '</select>',
      '</td>',
     '</tr>'
    ].join('');

    $('#pertrans').append(rowHTML);
 
    // add the behavior for "delete":
    //   1. remove the PerTran from the model
    //   2. remove the row (it's a <tr>)
    //   3. update the results
    $(idsel + ' .deletepertran').click(function() {
        self.cashFlow.removePerTran(id);
        $(idsel).remove();
    });

    // given a PerTran and a rowid (row selector), set the values of the widgets
    self.setRowValues(perTran, idsel);
    
    $(idsel + ' .amount').change(function() {
        try {
            perTran.setAmount($(this).val());
            $(this).removeClass('unsavedchange');
        } catch(e) {
            $(this).addClass('unsavedchange');
            alert('invalid amount: ' + e);
        }
    });
    
    $(idsel + ' .description').change(function() {
        try {
            perTran.setDescription($(this).val());
            $(this).removeClass('unsavedchange');
        } catch(e) {
            $(this).addClass('unsavedchange');
            alert('invalid description: ' + e);
        }
    });
    
    $(idsel + ' .period').change(function() {
        try {
            perTran.setPeriod($(this).val());
            $(this).removeClass('unsavedchange');
        } catch(e) {
            $(this).addClass('unsavedchange');
            alert('invalid period: ' + e);
        }
    });
    
    $(idsel + ' .type').change(function() {
        try {
            perTran.setType($(this).val());
            $(this).removeClass('unsavedchange');
        } catch(e) {
            $(this).addClass('unsavedchange');
            alert('invalid type: ' + e);
        }
    });
    
};




function AnalyzeView(analysis) {
  if (!(this instanceof AnalyzeView)) {
    throw {
      'type': 'constructor',
      'message': 'AnalyzeView Constructor called as a function'
    };
  }
  var self = this;
  analysis.bind('setActiveCashFlow', function(data) {
    self.setCashFlow(analysis.getCashFlow(data.name));
  });
}

AnalyzeView.prototype.setCashFlow = function(cashFlow) {
    // build new stuff
    //        add listeners
    //    create HTML
    this.undisplay();
    this.cashFlow = cashFlow;
    var self = this;
    this.cashFlow.bind('all', function(mess) {
      if(mess === 'valueChange' || mess === 'addPerTran' || mess === 'removePerTran') {
        self.display();
      }
    });
    this.display();
};

AnalyzeView.prototype.undisplay = function() {
    // get rid of old cashflow in edit + read:
    //    remove listeners
    //    clear HTML
    $('#results').empty();
    if(this.cashFlow) {
      this.cashFlow.unbind('all');
    }
};


AnalyzeView.prototype.clean = function(num) {
  // remove decimal places > 2 from number
  var regexp = /^-?\d+(?:\.\d{0,4})?/,
      m = (num + '').match(regexp);
  if(m) {
    return m;
  } else {
    throw {
      'type': 'value',
      'message': 'bad AnalyzeView amount: <' + num + '>'
    };
  }
};

AnalyzeView.prototype.makeRow = function(tp, res) {
    return '<tr><td>' + tp + '</td><td>' + 
           this.clean(res.credits) + '</td><td>' + 
           this.clean(res.debits) + '</td><td>' + 
           this.clean(res.total) + '</td></tr>';
};

AnalyzeView.prototype.display = function() {
    // header
    var table = $('#results'),
        results;
    table.empty();
    table.append('<tr><th>time period</th><th>credits</th><th>debits</th><th>total</th></tr>');
    results = [this.cashFlow.calculateWeek(), this.cashFlow.calculateMonth(), this.cashFlow.calculateYear()];
    //  rows:  week, month, year
    table.append(this.makeRow('week', results[0]));
    table.append(this.makeRow('month', results[1]));
    table.append(this.makeRow('year', results[2]));
};




function CashFlowView(analysis) {
  if (!(this instanceof CashFlowView)) {
    throw {
      'type': 'constructor',
      'message': 'CashFlowView constructor called as a function'
    };
  }

  var self = this;
  analysis.bind('addCashFlow', function addL(data) {
    self.row(data.name);
  });
      
  this.analysis = analysis;
  this.display();
}

CashFlowView.prototype.display = function() {
    var i,
        cfs = this.analysis.getCashFlows();
    $('#cashflows').empty();

    for(i = 0; i < cfs.length; i++) {
        this.row(cfs[i].name);
    }
};

CashFlowView.prototype.row = function(name) {
    var escaped = _.escape(name);
    $('#cashflows').append('<option value="' + escaped + '">' + escaped + '</option>');
};


return {
  'GridView': GridView,
  'CashFlowView': CashFlowView,
  'AnalyzeView': AnalyzeView
};

})(jQuery, _);
