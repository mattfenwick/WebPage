
// events that can be subscribed to:
//    getMessageSuccess    -- a new message or messages are available
//    getMessageFailure    -- a request for messages failed
//    saveMessageSuccess   -- a message was successfully saved
//    saveMessageFailure   -- a message could not be saved
//    addStatus            -- a new status update or updates pertaining to 
//                               message retrieval or saving are available
//    room&username        -- room and/or username was updated

function Model(room, username, dal) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }

    this.dal = dal;
    this.room = room;
    this.username = username;
    this.messages = [];
    this.statuses = [];
    this._listeners = {
        "getMessagesSuccess":    [],
        "getMessagesFailure":    [],
        "saveMessageSuccess":    [],
        "saveMessageFailure":    [],
        "addStatus":             [],
        "room&username":         []
    };
    
    var self = this;
    
    this.setRoomAndUserName = function(newRoom, newUserName) {
        if(newUserName.length > 0 && newRoom.length > 0) {
            if(self.room !== newRoom) {
                // blow away this.messages (if different)                
                self._setMessages([]);
                // get new messages should be taken care of by DAL
            }
            self.room = newRoom;
            self.username = newUserName;
            self._notifyListeners("room&username");
        } else {
            self.addStatus({
                type: "failure", 
                message: "room and/or username invalid"
            });
        }
    };
    
    // should be private?
    this._setMessages = function(newMessages) {
        self.messages = newMessages;
        self._notifyListeners("getMessagesSuccess"); // need new event?
    };
    
    this.addMessage = function(newText) {
        if(newText.length === 0) {
            self._notifyListeners("saveMessageFailure", "can not save empty message");
            self.addStatus({type: 'failure', message: 'can not save empty message'});
            return; // does this need a status update??
        }
        self.dal.saveMessage(self.username, self.room, newText);        
    };
    
    this.addStatus = function(newStatus) {
        this.statuses.push(newStatus);
        this._notifyListeners("addStatus", newStatus);
    };
    
    this.addListener = function(eType, listener) {
        var ls = this._listeners[eType];
        if(!ls) {
            throw "error: bad event type <" + eType + ">";
        }
        ls.push(listener);
    };
    
    this._notifyListeners = function(eType, data) {
        var ls = this._listeners[eType];
        if(!ls) {
            throw "error: bad event type <" + eType + ">";
        }
        ls.map(function(l) {
            l(data); // just execute each callback
        });
    };
    
    
    this.startGetMessages = function() {
        function fetchMessages() {
            self.dal.getMessages(self.room);
        };

        self.siId = setInterval(fetchMessages, 3000); // is this a long enough interval?
    };
    
    this.stopGetMessages = function() {
        clearInterval(self.siId);
    };
    
    
    /////////////////////////////////////////////////////////////
    // Data Access Layer callbacks
    // TODO also need to notify listeners of "addMessageSuccess", etc.
    
    this.dal.getMessagesFailure = function(error) {
        self._notifyListeners("getMessagesFailure", error);
        self.addStatus({
            type: 'failure', 
            message: error
        });
    };
    
    this.dal.getMessagesSuccess = function(newMessages) {
        self._setMessages(newMessages); // this also notifies the listeners
        self.addStatus({
            type: 'success', 
            message: 'got ' + newMessages.length + ' messages'
        });
    };
    
    this.dal.saveMessageFailure = function(error) {
        self._notifyListeners("saveMessageFailure", error);
        self.addStatus({
            type: 'failure', 
            message: error
        });
    };
    
    this.dal.saveMessageSuccess = function(sMessage) {
        self._notifyListeners("saveMessageSuccess", sMessage);
        self.addStatus({
            type: 'success',
            message: sMessage
        });
    };
    
}
