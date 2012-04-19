
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
      throw new Error("can't delete id <" + id + ">, doesn't exists");
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
    var camount = parseFloat(amount);
    if(!isNaN(camount) && camount == amount) {
        this.amount = camount;
    } else {
        throw new Error("bad amount: " + amount);
    }
    this.period = period;
    this.type = mytype;
    this.description = description;    
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

