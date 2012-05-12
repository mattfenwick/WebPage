
// ids and classes:
//   #messagehistory
//   #currentroom
//   #currentusername
//   #room
//   #username
//   #status
//   #text
//   #savemessage
//   #updateconfig
//   .time
//   .message
//   .messagetext
//   .username
//   .success
//   .failure

function Behavior($, model) {
    if (!(this instanceof Behavior)) {
        throw new Error("Constructor called as a function");
    }
    
    var self = this;

    self.messageTemplate = function(time, username, text) {
        var myHTML = [
          '<div class="message">', 
           '<span class="username">user: ' + username + '</span>',
           '<span class="time">time: '     + time     + '</span>',
           '<div class="messagetext">'     + text     + '</div>',
          '</div>'].join('');
        return myHTML;
    };
    
    self.setCurrentRoomAndUsername = function() {
        $("#currentroom").text(model.room);      
        $("#currentusername").text(model.username);
    };
    
    self.displayMessages = function() {
        var mh = $("#messagehistory");
        mh.empty();
        for(var i = 0; i < model.messages.length; i++) {
            var m = model.messages[i];
            mh.append(self.messageTemplate(m.time, m.username, m.text));
        }
        mh.scrollTop(mh.prop("scrollHeight"));
    };
    
    self.displayFailurePopup = function(message) {
        // TODO popup or something
    };
    
    self.displayStatus = function(s) {
        var st = $("#status");
        st.append('<p class="' + s.type + '">' + s.message + '</p>');
        st.scrollTop(st.prop("scrollHeight"));
    };
    
    self.clearText = function() {
        $("#text").val("");
    };
    
    self.saveMessage = function() {
        var text = $("#text").val();
        model.addMessage(text);
    };
    
    self.updateConfig = function() {
        var username = $("#username").val();
        var room = $("#room").val();
        model.setRoomAndUserName(room, username);
    };
    
    
    var added = 0;
    
    self.addBehavior = function () {
    	// prevent this from being called twice
    	if(added > 0) {
    		throw new Error("behavior already added");
    	}
    	added++;
        
        model.addListener("room&username", function(resp) {
            if(resp.status === "success") {
                self.setCurrentRoomAndUsername();
                self.displayStatus({type: 'success1', message: resp.message});
            } else {
                self.displayStatus({type: 'failure', message: resp.message});
            }
        });
    
        model.addListener("getMessages", function(resp) {
            if(resp.status === "success") {
                self.displayMessages();
                self.displayStatus({type: 'success2', message: resp.message});
            } else {
                self.displayStatus({type: 'failure', message: resp.message});
            }
        });
          
        model.addListener("saveMessage", function(resp) {
            if(resp.status === "success") {
                self.clearText();
                self.displayStatus({type: 'success3', message: resp.message});
            } else {
                self.displayStatus({type: 'failure', message: resp.message});
                self.displayFailurePopup();
            }
        });
        
        $("#savemessage").click(self.saveMessage);
    
        $("#updateconfig").click(self.updateConfig);

    };
}
