
function Analysis(cashFlows) {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
  this.cashFlows = {};
  this.counter = 1;
}

Analysis.prototype.addCashFlow = function(cashFlow) {
  if(!(cashFlow instanceof CashFlow)) {
    throw new Error("Analysis can only accept CashFlows");
  }
  var id = this.counter;
  this.cashFlows[id] = cashFlow;
  this.counter++;
  return id;
}

Analysis.prototype.removeCashFlow = function(id) {
  if(!(id in this.cashFlows)) {
    throw new Error("can't find CashFlow of id " + id);
  }
  delete this.cashFlows[id];
}

Analysis.prototype.getCashFlow = function(id) {
  if(id in this.cashFlows) {
    return this.cashFlows[id];
  } else {
    throw new Error("can't get CashFlow of id <" + id + ">, doesn't exist");
  }
}



function CashFlow() {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    this.perTrans = {};
    this.counter = 1;
    this.listeners = [];
}

CashFlow.prototype.addListener = function(l) {
  this.listeners.push(l);
}

CashFlow.prototype._notify = function(args) {
  for(var i = 0; i < this.listeners.length; i++) {
    this.listeners[i](args);
  }
}

CashFlow.prototype.removeListeners = function() {
  this.listeners = [];
  for(var i in this.perTrans) {
    this.perTrans[i].setListener(null); // just want to set it to a false value .... does this work?
  }
}

CashFlow.prototype.getPerTrans = function() {
    var perTrans = [];
    for(var x in this.perTrans) {
      perTrans.push(this.perTrans[x]);
    }
    return perTrans;
}

CashFlow.prototype.getPerTran = function(id) {
  if(id in this.perTrans) {
    return this.perTrans[id];
  } else {
    throw new Error("can't get id <" + id + ">, doesn't exist");
  }
}

CashFlow.prototype.addPerTran = function(perTran) {
  if(!(perTran instanceof PerTran)) {
    throw new Error("CashFlow needs PerTran instance");
  }
  var id = this.counter;
  this.perTrans[id] = perTran;
  this.counter++;
  this._notify({'message':'addPerTran', 'id': id});
  var self = this;
  perTran.setListener(function() {
      self._notify({"message":"valueChange", 'id': id});
  });
  return id;
}

CashFlow.prototype.removePerTran = function(id) {
    if(id in this.perTrans) {
      delete this.perTrans[id];
      this._notify({'message':'removePerTran', 'id': id});
    } else {
      throw new Error("can't delete id <" + id + ">, doesn't exist");
    }
}

// CashFlow -> Float
CashFlow.prototype.calculateYear = function() {
    var ptrans = this.getPerTrans();
    var total = 0;
    for(var i = 0; i < ptrans.length; i++) {
        var pt = ptrans[i];
        total += pt.getYearAmount();
    }
    return total;
}

CashFlow.prototype.calculateMonth = function() {
  return this.calculateYear() / 12;
}

CashFlow.prototype.calculateWeek = function() {
  return 7 * this.calculateYear() / 365;
}




function PerTran(amount, description, period, mytype) {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
  this.setAmount(amount);
  this.setPeriod(period);
  this.setType(mytype);
  this.setDescription(description);
}

PerTran.prototype.setListener = function(l) {
  this.listener = l;
}

PerTran.prototype._notify = function() {
  if(this.listener) {
    this.listener();
  }
}

PerTran.prototype.setAmount = function(amount) {
  var camount = parseFloat(amount);
  if(!isNaN(camount) && camount == amount) {
    this.amount = camount;
    this._notify();
  } else {
    throw new Error("bad amount: " + amount);
  }
}

PerTran.prototype.setPeriod = function(period) {
  if(period === "month" || period === "year") {
    this.period = period;
    this._notify();
  } else {
    throw new Error("bad period: " + period);
  }
}

PerTran.prototype.setDescription = function(d) {
  this.description = d;
  this._notify();
}

PerTran.prototype.setType = function(mytype) {
  if(mytype === "debit" || mytype === "credit") {
    this.type = mytype;
    this._notify();
  } else {
    throw new Error("bad type: " + mytype);
  }
}

PerTran.prototype.getAmount = function() {
  var mult = 1;
  var pt = this;
  if(pt.type === "debit") {
    mult = -1;
  }
  return pt.amount * mult;
}

PerTran.prototype.getYearAmount = function() {
  var mult = 1;
  if(this.period === "month") {
    mult = 12;
  }
  return this.getAmount() * mult;
}

