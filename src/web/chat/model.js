
function Model(room, username) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    
    this.room = room;
    this.username = username;
    this.messages = [];
    this.statuses = [];
    this.listeners = [];
    
    this.setRoomAndUserName = function(newRoom, newUserName) {
        if(username.length > 0 && room.length > 0) {
            // blow away this.messages (if different)
            // get new messages
            this.room = room;
            this.notifyListeners("roomandusername");
        } else {
            alert("please enter a username and room!");
        }
    }
    
    // should be private?
    this._setMessages = function(newMessages) {
        this.messages = newMessages;
        this.notifyListeners("message");
    }
    
    this.addMessage = function(newText) {
    	// TODO
        if(newText.length !== 0) {
            //saveMessage(username, room, text);
        } else {
            alert("please enter a message!");
        }
        this.notifyListeners("message");
    }
    
    this.addStatus = function(newStatus) {
    	this.statuses.push(newStatus);
    	this.notifyListeners("status");
    }
    
    this.addListener = function(listener) {
        this.listeners.push(listener);
    }
    
    // TODO should be private?
    this.notifyListeners = function(eType) {
        this.listeners.map(function(l) {
            l(eType);
        });
    }
}
