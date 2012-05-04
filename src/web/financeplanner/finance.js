
function Analysis() {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
  this.cashFlows = {};
  this.activeCashFlow = null;
  this.listeners = [];
}

Analysis.prototype.setActiveCashFlow = function(name) {
  if(!(name in this.cashFlows)) {
    throw new Error("can't find CashFlow of name " + name);
  } else {
    this.activeCashFlow = this.cashFlows[name];
    this._notify({"message": "setActiveCashFlow", 'name': name});
  }
};

Analysis.prototype.addCashFlow = function(cashFlow) {
  if(!(cashFlow instanceof CashFlow)) {
    throw new Error("Analysis can only accept CashFlows");
  }
  if(cashFlow.name in this.cashFlows) {
    throw new Error("cashflow name " + cashFlow.name + " already in use");
  }
  this.cashFlows[cashFlow.name] = cashFlow;
  this._notify({'message': 'addCashFlow', 'name': cashFlow.name});
};

Analysis.prototype.removeCashFlow = function(name) {
  if(!(name in this.cashFlows)) {
    throw new Error("can't find CashFlow of name " + name);
  }
  delete this.cashFlows[name];
  this._notify({'message': 'removeCashFlow', 'name': name});
};

Analysis.prototype.getCashFlow = function(name) {
  if(name in this.cashFlows) {
    return this.cashFlows[name];
  } else {
    throw new Error("can't get CashFlow of name <" + name + ">, doesn't exist");
  }
};

Analysis.prototype.getCashFlows = function() {
  var cfs = [];
  for(var name in this.cashFlows) {
    cfs.push(this.cashFlows[name]);
  }
  return cfs;
};

Analysis.prototype._notify = function(data) {
  for(var i = 0; i < this.listeners.length; i++) {
    this.listeners[i](data);
  }
};

Analysis.prototype.addListener = function(l) {
  this.listeners.push(l);
};




function CashFlow(name) {
  if (!(this instanceof arguments.callee)) {
    throw new Error("Constructor called as a function");
  }
  this.setName(name);
  this.perTrans = {};
  this.counter = 1;
  this.listeners = [];
}

CashFlow.prototype.setName = function(name) {
  if(typeof name === "string" && name.length > 0) {
    this.name = name;
  } else {
    throw new Error("CashFlow name must be a non-empty string");
  }
};

CashFlow.prototype.addListener = function(l) {
  this.listeners.push(l);
};

CashFlow.prototype._notify = function(args) {
  for(var i = 0; i < this.listeners.length; i++) {
    this.listeners[i](args);
  }
};

CashFlow.prototype.removeListeners = function() {
  this.listeners = [];
};

CashFlow.prototype.getPerTrans = function() {
  return this.perTrans;
};

CashFlow.prototype.getPerTran = function(id) {
  if(id in this.perTrans) {
    return this.perTrans[id];
  } else {
    throw new Error("can't get id <" + id + ">, doesn't exist");
  }
};

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
};

CashFlow.prototype.removePerTran = function(id) {
  if(id in this.perTrans) {
    delete this.perTrans[id];
    this._notify({'message':'removePerTran', 'id': id});
  } else {
    throw new Error("can't delete id <" + id + ">, doesn't exist");
  }
};

CashFlow.prototype._getPerTransArray = function() {
  var perTrans = [];
  for(var x in this.perTrans) {
    perTrans.push(this.perTrans[x]);
  }
  return perTrans;
};

CashFlow.prototype.calculateYear = function() {
  var pt, amt;
  var ptrans = this._getPerTransArray();
  var ptotal = 0;
  var total = 0;
  var ntotal = 0;
  for(var i = 0; i < ptrans.length; i++) {
    pt = ptrans[i];
    amt = pt.getYearAmount();
    total += amt;
    if(amt > 0) {
      ptotal += amt;
    } else {
      ntotal += amt;
    }
  }
  return {
    'total': total,
    'credits': ptotal,
    'debits': ntotal
  };
};

CashFlow.prototype.calculateMonth = function() {
  var year = this.calculateYear();
  var month = {};
  for(var per in year) {
    month[per] = year[per] / 12;
  }
  return month;
};

CashFlow.prototype.calculateWeek = function() {
  var year = this.calculateYear();
  var week = {};
  for(var per in year) {
    week[per] = year[per] * 7 / 365;
  }
  return week;
};




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
};

PerTran.prototype._notify = function() {
  if(this.listener) {
    this.listener();
  }
};

PerTran.prototype.setAmount = function(amount) {
  var camount = parseFloat(amount);
  if(!isNaN(camount) && camount == amount) {
    this.amount = camount;
    this._notify();
  } else {
    throw new Error("bad amount: " + amount);
  }
};

PerTran.prototype.setPeriod = function(period) {
  if(period === "month" || period === "year") {
    this.period = period;
    this._notify();
  } else {
    throw new Error("bad period: " + period);
  }
};

PerTran.prototype.setDescription = function(d) {
  this.description = d;
  this._notify();
};

PerTran.prototype.setType = function(mytype) {
  if(mytype === "debit" || mytype === "credit") {
    this.type = mytype;
    this._notify();
  } else {
    throw new Error("bad type: " + mytype);
  }
};

PerTran.prototype.getAmount = function() {
  var mult = 1;
  var pt = this;
  if(pt.type === "debit") {
    mult = -1;
  }
  return pt.amount * mult;
};

PerTran.prototype.getYearAmount = function() {
  var mult = 1;
  if(this.period === "month") {
    mult = 12;
  }
  return this.getAmount() * mult;
};
