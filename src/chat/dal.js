
// event types for listeners to subscribe to:
//    saveMessage
//    getMessages

function Dal() {
    if (!(this instanceof Dal)) {
        throw new Error('Constructor called as a function');
    }
    
    this._listeners = {
        getMessages:  [],
        saveMessage:  []
    };
    
    this.saveUrl = 'chat.php';
    this.getUrl = 'chat.php';
    
    var self = this;
    
    
    this._onSaveResponse = function(res) {
      	self._notifyListeners('saveMessage', res);
    };
    
    this.saveMessage = function(username, room, text) {
        var request = $.ajax({
            url:       self.saveUrl, 
            type:      'POST',
            dataType:  'json',
            data:      {
        	    username: username,
                room: room,
                text: text,
                type: 'savemessage'
            },
            success:   self._onSaveResponse,
            error:     function(resp, message) {
            	self._notifyListeners('saveMessage', {
                    status: 'failure',
                    message: 'http save request failed: ' + message,
                    response: resp
                });
            },
            timeout:   2000 // is this long enough?
        });
    };
    
        
    this._onGetResponse = function(res) {
        self._notifyListeners('getMessages', res);
    };
    
    this.getMessages = function(room) {
    	var request = $.ajax({
            url:       self.getUrl,
            type:      'GET',
            dataType:  'json',
            data:      {
                type: 'getallmessages', 
                room: room
            },
            success:   self._onGetResponse,
            timeout:   2000, // is this long enough?
            error:     function(resp, message) {
                self._notifyListeners('getMessages', {
                    status: 'failure',
                    message: 'http get request failed: ' + message, 
                    response: resp
                });
            }
        });    
    };
    
    ///////////////////////////////////////////////////////////////////////////
    /////
    
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
}
