
// assumes following callbacks exist (as methods on "this"):
//    saveMessageSuccess
//    saveMessageFailure
//    getMessagesSuccess
//    getMessagesFailure
function Dal() {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    
    var self = this;
    
    
    
    this._onSaveResponse = function(res) {
        if("success" in res) {
        	self.saveMessageSuccess(res);
        } else {
        	self.saveMessageFailure(res);
        }
    };
    
    this.saveMessage = function(username, room, text) {
        var request = $.ajax({
            url:       'chat.php', 
            type:      'POST',
            dataType:  'json',
            data:      {
        	    'username': username,
                'room': room,
                'text': text,
                'type': 'savemessage'
            },
            success:   self._onSaveResponse,
            error:     function(resp, message) {
            	self.saveMessageFailure('http save request failed: ' + message, resp);
            },
            timeout:   2000 // is this long enough?
        });
    };
    
    
        
    this._onGetResponse = function(res) {
        if ("success" in res){
        	self.getMessagesSuccess(response);
        } else {
            self.getMessagesFailure("received invalid response", res.error);// error key?
        }
    };
    
    this.getMessages = function(room) {
    	var request = $.ajax({
            url:       'chat.php',
            type:      'GET',
            dataType:  'json',
            data:      {'type': 'getallmessages', 'room': room},
            success:   self._onGetResponse,
            timeout:   2000, // is this long enough?
            error:     function(resp, message) {
                self.getMessagesFailure("http request failed: " + message, resp);
            }
        });    
    };
}
