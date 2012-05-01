
function GridView() {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
}

GridView.prototype._cleanUp = function() {

}

GridView.prototype.setCashFlow = function(cashFlow) {
  // get rid of old cashflow in edit + read:
  //    remove listeners
  //    clear HTML
  //    check for unsaved work?  
  // build new stuff
  //    add listeners
  //    create HTML
  alert("unimplemented");
  this.undisplay();
  this.cashFlow = cashFlow;
  this.display();
}

GridView.prototype.display = function() {
  var perTrans = this.cashFlow.getPerTrans();
  for(var id in perTrans) {
    this.makeRow(id, perTrans[id]);
  }
}

GridView.prototype.undisplay = function() {
  
}

GridView.prototype.updatePTran = function(id, sel) {
    try {
      var pt = cf.getPerTran(id);

      pt.setAmount(     $(sel + " .amount"     ).val());
      pt.setDescription($(sel + " .description").val());
      pt.setPeriod(     $(sel + " .period"     ).val());
      pt.setType(       $(sel + " .type"       ).val());

      $(sel + " .inputfield").removeClass("redoutline");
      updateYearTotal();
    } catch(e) {// bug: when some succeed before one fails ... then gui is not consistent with model
      alert("error: " + e);
    }
}

GridView.prototype.setRowValues = function(perTran, sel) {
    $(sel + " .amount"     ).val(perTran.amount     );
    $(sel + " .description").val(perTran.description);
    $(sel + " .period"     ).val(perTran.period     );
    $(sel + " .type"       ).val(perTran.type       );
}

GridView.prototype.makeRow = function(id, perTran) {
    var self = this;
    var rowHTML = [
     '<tr id="' + id + '">',
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
    ].join('\n');

    // put in the new row right before #newrow
    $("#newrow").before(rowHTML);

    var idsel = "#" + id;
 
    // add the behavior for "delete":
    //   1. remove the PerTran from the model
    //   2. remove the row (it's a <tr>)
    //   3. update the results
    $(idsel + " .deletepertran").click(function() {
      cf.removePerTran(id);
      $(idsel).remove();
    });

    // given a PerTran and a rowid (row selector), set the values of the widgets
    self.setRowValues(perTran, idsel);

    // whenever a field is changed (i.e. loses focus):
    //   1. write the changes into the PerTran object
    //   2. update the results
    $(idsel + " .inputfield").change(function() {
      self.updatePTran(id, idsel);
    });
}





function AnalyzeView() {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
}

AnalyzeView.prototype.setCashFlow = function(cashFlow) {
  // get rid of old cashflow in edit + read:
  //    remove listeners
  //    clear HTML
  //    check for unsaved work?
  // build new stuff
  //    add listeners
  //    create HTML
  alert("unimplemented");
  this.cashFlow = cashFlow;
  this.display();
}

AnalyzeView.prototype._setup = function() {
  var self = this;
  function f(data) {
    var m = data.message;
    if(m === "valueChange" || m === "addPerTran" || m === "removePerTran") {
      self.displayResults();
    }
  }
  this.cashFlow.addListener(f);
}

AnalyzeView.prototype._cleanUp = function() {
  this.cashFlow.removeListeners();
}

AnalyzeView.prototype.makeRow = function(tp, res) {
  return '<tr><td>' + tp + '</td><td>' + res.credits + '</td><td>' + res.debits + '</td><td>' + res.total + '</td></tr>';
}

AnalyzeView.prototype.display = function() {
  // empty out the old table
  $("#" + tableId).empty();
  // header
  $("#" + tableId).append('<tr><th>time period</th><th>credits</th><th>debits</th><th>total</th></tr>');
  var results = [this.cashFlow.calculateWeek(), this.cashFlow.calculateMonth(), this.cashFlow.calculateYear()];
  //  rows:  week, month, year
  $("#" + tableId).append(this.makeRow("week", results[0]));
  $("#" + tableId).append(this.makeRow("month", results[1]));
  $("#" + tableId).append(this.makeRow("year", results[2]));
}




function CashFlowView(analysis) {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }

  var self = this;
  function f(data) {
    if (data.message === "addCashFlow") {
      self.display();
    }
  }
  analysis.addListener(f);

  this.analysis = analysis;
  this.display();
}

CashFlowView.prototype.display = function() {
  var cf;
  var cfs = this.analysis.getCashFlows();
  $("#cashflows").empty();

  for(var i = 0; i < cfs.length; i++) {
    cf = cfs[i];
    $("#cashflows").append('<select value="' + cf.name + '">' + cf.name + '</select>');
  }
}

