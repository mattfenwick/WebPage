
function Behavior($, model) {
    if (!(this instanceof arguments.callee)) {
        throw new Error("Constructor called as a function");
    }
    
    var self = this;

    self.messageTemplate = function(time, username, text) {
        var myHTML = '<div><span class="time">time: ' + time + 
        '</span><span class="username">' + 'user: ' +
        username + '</span>' + '<div class="message">' + 
        text + '</div></div>';
        return myHTML;
    };
    
    self.setCurrentRoomAndUsername = function(data) {
        $("#currentroom").text("current room: " + model.room);      
        $("#currentusername").text("current username: " + model.username);
    };
    
    self.displayMessages = function() {
        var mh = $("#messagehistory");
        mh.empty();
        for(var i = 0; i < model.messages.length; i++) {
            var m = model.messages[i];
            mh.append(messageTemplate(m.time, m.username, m.text));
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
    	// what if this is called twice?
    	if(added > 0) {
    		throw new Error("behavior already added");
    	}
    	added++;
    	
        // listener for the room and username 
        model.addListener("room&username", self.setCurrentRoomAndUsername);
    
        // listener for a new message 
        model.addListener("getMessagesSuccess", self.displayMessages);
    
        // listener for a message retrieval failure 
        model.addListener("getMessagesFailure", self.displayFailurePopup);
          
        // listener for a message persistence failure 
        model.addListener("saveMessageFailure", self.displayFailurePopup);
    
        // listener for a new status update 
        model.addListener("addStatus", self.displayStatus);
    
        // listener for a successful message save 
        model.addListener("saveMessageSuccess", self.clearText);
          
        
        $("#savemessage").click(self.saveMessage);
    
        $("#updateconfig").click(self.updateConfig);
    
        $("#togglestatus").click(function() {
            $("#status").toggle(500);
        });
          
        $("#showconfig").click(function() {
            $("#setconfig").toggle(500); 
        }).click();
    };
}
