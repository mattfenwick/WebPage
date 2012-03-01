
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
    
    this.room = room;
    this.username = username;
    this.messages = [];
    this.statuses = [];
    this.listeners = {
        "getMessageSuccess":    [],
        "getMessageFailure":    [],
        "saveMessageSuccess":   [],
        "saveMessageFailure":   [],
        "addStatus":            [],
        "room&username":        []
    };
    
    this.setRoomAndUserName = function(newRoom, newUserName) {
        if(username.length > 0 && room.length > 0) {
            if(this.room !== newRoom) {
                // blow away this.messages (if different)                
                // get new messages
            }
            this.room = newRoom;
            this.username = newUserName;
            this._notifyListeners("room&username", {username: newUserName, room: newRoom});
        } else {
            alert("please enter a username and room!");
        }
    };
    
    // should be private?
    this._setMessages = function(newMessages) {
        this.messages = newMessages;
        this._notifyListeners("message");
    };
    
    this.addMessage = function(newText) {
        // TODO
        if(newText.length === 0) {
            alert("please enter a message!");
            return; // does this need a status update??
        }
        this.dal.saveMessage(this.username, this.room, newText);        
        this._notifyListeners("saveMessageSuccess");
    };
    
    this.addStatus = function(newStatus) {
        this.statuses.push(newStatus);
        this._notifyListeners("addStatus", newStatus);
    };
    
    this.addListener = function(eType, listener) {
        var ls = this.listeners[eType];
        if(!ls) {
            throw "error: bad event type <" + eType + ">";
        }
        ls.push(listener);
    };
    
    this._notifyListeners = function(eType, data) {
        var ls = this.listeners[eType];
        if(!ls) {
            throw "error: bad event type <" + eType + ">";
        }
        ls.map(function(l) {
            l(data); // just execute each callback
        });
    };
    
    
    /////////////////////////////////////////////////////////////
    // Data Access Layer callbacks
    // TODO also need to notify listeners of "addMessageSuccess", etc.
    var self = this;
    
    this.dal.getMessagesFailure = function(error) {
        self.addStatus({
        	type: 'failure', 
        	message: error
        });
    };
    
    this.dal.getMessagesSuccess = function(newMessages) {
        self._setMessages(newMessages);
        self.addStatus({
        	type: 'success', 
        	message: 'got ' + newMessages.length + ' messages'
        });
    };
    
    this.dal.saveMessagesFailure = function(error) {
        self.addStatus({
        	type: 'failure', 
        	message: error
        });
    };
    
    this.dal.saveMessageSuccess = function() {
    	self.addStatus({
    		type: 'success',
    		message: 'message saved successfully'
    	});
    };
}
