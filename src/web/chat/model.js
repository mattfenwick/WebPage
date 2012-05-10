
// events that can be subscribed to:
//    getMessage     -- a new message or messages are available
//    saveMessage    -- a message was successfully saved
//    room&username  -- room and/or username was updated

function Model(room, username, dal) {
    if (!(this instanceof Model)) {
        throw new Error('Constructor called as a function');
    }
    
    this.setDal(dal);

    this.room = room;
    this.username = username;
    this.messages = [];
    this._listeners = {
        getMessages:    [],
        saveMessage:    [],
        'room&username':  []
    };
    
    var self = this;
    
    // should be private?
    this._setMessages = function(newMessages) {
        self.messages = newMessages;
        self._notifyListeners('getMessages', {
            status: 'success',
            message: 'messages retrieved'
        }); // need new event?
    };
    
    this.addMessage = function(newText) {
        if(newText.length === 0) {
            self._notifyListeners('saveMessage', {
                status: 'failure',
                message: 'can not save empty message'
            });
        } else {
            self.dal.saveMessage(self.username, self.room, newText);
        }
    };
    
    this.addListener = function(eType, listener) {
        var ls = this._listeners[eType];
        if(!ls) {
            throw 'error: bad event type <' + eType + '>';
        }
        ls.push(listener);
    };
    
    this._notifyListeners = function(eType, data) {
        var ls = this._listeners[eType];
        if(!ls) {
            throw 'error: bad event type <' + eType + '>';
        }
        ls.map(function(l) {
            l(data); // just execute each callback
        });
    };
    
    
    var stop = true;
    this.startGetMessages = function() {
        stop = false;
        function fetchMessages() {
            self.dal.getMessages(self.room);
            if(!stop) {
                setTimeout(fetchMessages, 2500);
            }
        }
        fetchMessages();
    };
    
    this.stopGetMessages = function() {
        stop = true;
    };
}

Model.prototype.setRoomAndUserName = function(newRoom, newUserName) {
    var self = this;
    if(newUserName.length > 0 && newRoom.length > 0) {
        if(self.room !== newRoom) {
            // blow away this.messages (if different)                
            self._setMessages([]);
            // get new messages should be taken care of by DAL
        }
        self.room = newRoom;
        self.username = newUserName;
        self._notifyListeners('room&username', {
            status: 'success',
            message: 'room and username update'
        });
    } else {
    	self._notifyListeners('room&username', {
            status: 'error',
            message: 'room and/or username invalid'
        });
    }
};


Model.prototype.setDal = function(dal) {
    // doesn't remove listeners from old dal (if there are any)
    this.dal = dal;
    var self = this;
    this.dal.addListener('getMessages', function(resp) {
        if(resp.status === 'success') {
            self._setMessages(resp.messages); // this also notifies the listeners
        } else {
            self._notifyListeners('getMessages', resp);
        }
    });
    
    this.dal.addListener('saveMessage', function(resp) {
        self._notifyListeners('saveMessage', resp);
    });
};
