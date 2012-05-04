
function GridView(analysis) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    var self = this;
    analysis.addListener(function(data) {
        if(data.message === "setActiveCashFlow") {
            self.setCashFlow(analysis.getCashFlow(data.name));
        }
    });
    this.cashFlow = null;
}

GridView.prototype.setCashFlow = function(cashFlow) { 
    this.undisplay();
    this.cashFlow = cashFlow;
    this.display();
};

GridView.prototype.display = function() {
    // build new stuff
    //    add listeners
    //    create HTML
    var header = [
      '<tr>', 
      '<th>Action</th>', 
      '<th>Amount</th>', 
      '<th>Description</th>', 
      '<th>Period</th>',
      '<th>Debit/credit</th>', 
      '</tr>'].join('');
    var newrow = [
      '<tr id="newrow">',
      '<td><button>Create new</button></td>',
      '<td></td>',
      '<td></td>',
      '<td></td>',
      '<td></td>',
      '</tr>'].join('');
    $("#pertrans").append(header);
    $("#pertrans").append(newrow);

    var self = this;

    $("#newrow").click(function() {
        try {
            var ptran = new PerTran(0, "", "month", "debit");
            var id = self.cashFlow.addPerTran(ptran);
            self.makeRow(id, ptran);
        } catch(e) {
            alert(e);
        }
    });
   
    var perTrans = this.cashFlow.getPerTrans();
    for(var id in perTrans) {
        this.makeRow(id, perTrans[id]);
    }
};

GridView.prototype.undisplay = function() {
    // get rid of old cashflow:
    //    remove listeners
    //    clear HTML
    //    check for unsaved work? 
    if(this.cashFlow) {
        this.cashFlow.removeListeners();
    }
    $("#pertrans").empty();
};

GridView.prototype.setRowValues = function(perTran, sel) {
    $(sel + " .amount"     ).val(perTran.amount     );
    $(sel + " .description").val(perTran.description);
    $(sel + " .period"     ).val(perTran.period     );
    $(sel + " .type"       ).val(perTran.type       );
};

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
    ].join('');

    // put in the new row right before #newrow
    $("#newrow").before(rowHTML);

    var idsel = "#" + id;
 
    // add the behavior for "delete":
    //   1. remove the PerTran from the model
    //   2. remove the row (it's a <tr>)
    //   3. update the results
    $(idsel + " .deletepertran").click(function() {
        self.cashFlow.removePerTran(id);
        $(idsel).remove();
    });

    // given a PerTran and a rowid (row selector), set the values of the widgets
    self.setRowValues(perTran, idsel);
    
    $(idsel + " .amount").change(function() {
        try {
            perTran.setAmount($(this).val());
            $(this).removeClass("unsavedchange");
        } catch(e) {
            $(this).addClass("unsavedchange");
            alert("invalid amount: " + e);
        }
    });
    
    $(idsel + " .description").change(function() {
        try {
            perTran.setDescription($(this).val());
            $(this).removeClass("unsavedchange");
        } catch(e) {
            $(this).addClass("unsavedchange");
            alert("invalid description: " + e);
        }
    });
    
    $(idsel + " .period").change(function() {
        try {
            perTran.setPeriod($(this).val());
            $(this).removeClass("unsavedchange");
        } catch(e) {
            $(this).addClass("unsavedchange");
            alert("invalid period: " + e);
        }
    });
    
    $(idsel + " .type").change(function() {
        try {
            perTran.setType($(this).val());
            $(this).removeClass("unsavedchange");
        } catch(e) {
            $(this).addClass("unsavedchange");
            alert("invalid type: " + e);
        }
    });
    
};




function AnalyzeView(analysis) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    var self = this;
    analysis.addListener(function(data) {
        if(data.message === "setActiveCashFlow") {
            self.setCashFlow(analysis.getCashFlow(data.name));
        }
    });
}

AnalyzeView.prototype.setCashFlow = function(cashFlow) {
    // build new stuff
    //        add listeners
    //    create HTML
    this.undisplay();
    this.cashFlow = cashFlow;
    var self = this;
    this.cashFlow.addListener(function(data) {
          var mess = data.message;
          if(mess === "valueChange" || mess === "addPerTran" || mess === "removePerTran") {
              self.display();
          }
    });
    this.display();
};

AnalyzeView.prototype.undisplay = function() {
    // get rid of old cashflow in edit + read:
    //    remove listeners
    //    clear HTML
    $("#results").empty();
    if(this.cashFlow) {
        this.cashFlow.removeListeners();
    }
};

AnalyzeView.prototype.makeRow = function(tp, res) {
    return '<tr><td>' + tp + '</td><td>' + res.credits + '</td><td>' + res.debits + '</td><td>' + res.total + '</td></tr>';
};

AnalyzeView.prototype.display = function() {
    // header
    var table = $("#results");
    table.empty();
    table.append('<tr><th>time period</th><th>credits</th><th>debits</th><th>total</th></tr>');
    var results = [this.cashFlow.calculateWeek(), this.cashFlow.calculateMonth(), this.cashFlow.calculateYear()];
    //  rows:  week, month, year
    table.append(this.makeRow("week", results[0]));
    table.append(this.makeRow("month", results[1]));
    table.append(this.makeRow("year", results[2]));
};




function CashFlowView(analysis) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }

    var self = this;
    function addL(data) {
        if (data.message === "addCashFlow") {
            self.row(data.name);
        }
    }
    analysis.addListener(addL);
    
    function setActiveL(data) {
        if (data.message === "setActiveCashFlow") {
            $("#cashflows li").removeClass("selected").each(function(ix, el) {
                if($(this).text() === data.name) {
                    $(this).addClass("selected");
                    return false;
                }
            });
        }
    }
    analysis.addListener(setActiveL);
  
    this.analysis = analysis;
    this.display();
}

CashFlowView.prototype.display = function() {
    var cf;
    var cfs = this.analysis.getCashFlows();
    $("#cashflows").empty();

    for(var i = 0; i < cfs.length; i++) {
        this.row(cfs[i].name);
    }
};

CashFlowView.prototype.row = function(name) {
    $("#cashflows").append('<li>' + name + '</li>');
};
