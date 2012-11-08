
var Model = (function(_, Backbone) {
"use strict";

function Analysis() {
  if (!(this instanceof Analysis)) {
    throw {
      'type': 'constructor',
      'message': 'Analysis constructor called as a function'
    };
  }
  this.cashFlows = {};
  this.activeCashFlow = null;
}

Analysis.prototype.setActiveCashFlow = function(name) {
  if(!(name in this.cashFlows)) {
    throw {
      'type': 'value',
      'message': "can't find CashFlow of name " + name
    };
  } else {
    this.activeCashFlow = this.cashFlows[name];
    this.trigger('setActiveCashFlow', {'name': name});
  }
};

Analysis.prototype.getActiveCashFlow = function() {
  return this.activeCashFlow;
};

Analysis.prototype.addCashFlow = function(cashFlow) {
  if(!(cashFlow instanceof CashFlow)) {
    throw {
      'type': 'type',
      'message': 'Analysis can only accept CashFlows'
    };
  }
  if(cashFlow.name in this.cashFlows) {
    throw {
      'type': 'value',
      'message': 'cashflow name ' + cashFlow.name + ' already in use'
    };
  }
  this.cashFlows[cashFlow.name] = cashFlow;
  this.trigger('addCashFlow', {'name': cashFlow.name});
};

Analysis.prototype.removeCashFlow = function(name) {
  if(!(name in this.cashFlows)) {
    throw {
      'type': 'value',
      'message': "can't find CashFlow of name " + name
    };
  }
  delete this.cashFlows[name];
  this.trigger('removeCashFlow', {'name': name});
};

Analysis.prototype.getCashFlow = function(name) {
  if(name in this.cashFlows) {
    return this.cashFlows[name];
  } else {
    throw {
      'type': 'value',
      'message': "can't get CashFlow of name <" + name + ">, doesn't exist"
    };
  }
};

Analysis.prototype.getCashFlows = function() {
  var cfs = [],
      name;
  for(name in this.cashFlows) {
    cfs.push(this.cashFlows[name]);
  }
  return cfs;
};

_.extend(Analysis.prototype, Backbone.Events);




function CashFlow(name) {
  if (!(this instanceof CashFlow)) {
    throw {
      'type': 'constructor',
      'message': 'CashFlow constructor called as a function'
    };
  }
  this.setName(name);
  this.perTrans = {};
  this.counter = 1;
}

CashFlow.prototype.setName = function(name) {
  if(typeof name === 'string' && name.length > 0) {
    this.name = name;
  } else {
    throw {
      'type': 'value',
      'message': 'CashFlow name must be a non-empty string'
    };
  }
};

CashFlow.prototype.getPerTrans = function() {
  return this.perTrans;
};

CashFlow.prototype.getPerTran = function(id) {
  if(id in this.perTrans) {
    return this.perTrans[id];
  } else {
    throw {
      'type': 'value',
      'message': "can't get id <" + id + ">, doesn't exist"
    };
  }
};

CashFlow.prototype.addPerTran = function(perTran) {
  if(!(perTran instanceof PerTran)) {
    throw {
      'type': 'type',
      'message': 'CashFlow needs PerTran instance'
    };
  }
  var id = this.counter,
      self = this;
  this.perTrans[id] = perTran;
  this.counter++;
  this.trigger('addPerTran', {'id': id});
  perTran.bind('all', function(field) {
    self.trigger('valueChange', {'id': id, 'field': field});
  });
  return id;
};

CashFlow.prototype.removePerTran = function(id) {
  if(id in this.perTrans) {
    delete this.perTrans[id];
    this.trigger('removePerTran', {'id': id});
  } else {
    throw {
      'type': 'value',
      'message': "can't delete id <" + id + ">, doesn't exist"
    };
  }
};

CashFlow.prototype._getPerTransArray = function() {
  var perTrans = [],
      x;
  for(x in this.perTrans) {
    perTrans.push(this.perTrans[x]);
  }
  return perTrans;
};

CashFlow.prototype.calculateYear = function() {
  var pt, amt, i,
      ptrans = this._getPerTransArray(),
      ptotal = 0,
      total = 0,
      ntotal = 0;
  for(i = 0; i < ptrans.length; i++) {
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
  var year = this.calculateYear(),
      month = {},
      per;
  for(per in year) {
    month[per] = year[per] / 12;
  }
  return month;
};

CashFlow.prototype.calculateWeek = function() {
  var year = this.calculateYear(),
      week = {},
      per;
  for(per in year) {
    week[per] = year[per] * 7 / 365;
  }
  return week;
};

_.extend(CashFlow.prototype, Backbone.Events);




function PerTran(amount, description, period, mytype) {
  if (!(this instanceof PerTran)) {
    throw {
      'type': 'constructor',
      'message': 'PerTran constructor called as a function'
    };
  }
  // match:
  //   1. integer with optional decimal point
  //   2. decimal with up to 2 places after, 0 to n before
  this.amountRegex = /^(?:\d+\.?|\d*\.\d{1,2})$/;

  this.setAmount(amount);
  this.setPeriod(period);
  this.setType(mytype);
  this.setDescription(description);
}

PerTran.prototype.setAmount = function(amount) {
  var camount = parseFloat(amount);
  if(!isNaN(camount) && 
       camount == amount && 
       camount >= 0 && 
       (amount + '').match(this.amountRegex)) {
    this.amount = camount;
    this.trigger("amount");
  } else {
    throw {
      'type': 'value',
      'message': 'bad transaction amount: ' + amount
    };
  }
};

PerTran.prototype.setPeriod = function(period) {
  if(period === 'month' || period === 'year') {
    this.period = period;
    this.trigger("period");
  } else {
    throw {
      'type': 'value',
      'message': 'bad period: ' + period
    };
  }
};

PerTran.prototype.setDescription = function(d) {
  this.description = d;
  this.trigger("description");
};

PerTran.prototype.setType = function(mytype) {
  if(mytype === 'debit' || mytype === 'credit') {
    this.type = mytype;
    this.trigger("type");
  } else {
    throw {
      'type': 'value',
      'message': 'bad type: ' + mytype
    };
  }
};

PerTran.prototype.getAmount = function() {
  var mult = 1;
  if(this.type === 'debit') {
    mult = -1;
  }
  return this.amount * mult;
};

PerTran.prototype.getYearAmount = function() {
  var mult = 1;
  if(this.period === 'month') {
    mult = 12;
  }
  return this.getAmount() * mult;
};

_.extend(PerTran.prototype, Backbone.Events);



return {
  'PerTran': PerTran,
  'CashFlow': CashFlow,
  'Analysis': Analysis
};

})(_, Backbone);
