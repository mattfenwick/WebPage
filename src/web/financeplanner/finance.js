
function CashFlow() {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    this.perTrans = {};
    this.counter = 1;
}

CashFlow.prototype.getPerTrans = function() {
    var perTrans = [];
    for(x in this.perTrans) {
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
    // assume perTran is an instance of PerTran
    var id = this.counter;
    this.perTrans[id] = perTran;
    this.counter++;
    return id;
}

CashFlow.prototype.removePerTran = function(id) {
    if(id in this.perTrans) {
      delete this.perTrans[id];
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




function PerTran(amount, description, period, mytype) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    this.setAmount(amount);
    this.setPeriod(period);
    this.setType(mytype);
    this.setDescription(description);
}

PerTran.prototype.setAmount = function(amount) {
    var camount = parseFloat(amount);
    if(!isNaN(camount) && camount == amount) {
        this.amount = camount;
    } else {
        throw new Error("bad amount: " + amount);
    }
}

PerTran.prototype.setPeriod = function(period) {
  if(period === "month" || period === "year") {
    this.period = period;
  } else {
    throw new Error("bad period: " + period);
  }
}

PerTran.prototype.setDescription = function(d) {
  this.description = d;
}

PerTran.prototype.setType = function(mytype) {
  if(mytype === "debit" || mytype === "credit") {
    this.type = mytype;
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

