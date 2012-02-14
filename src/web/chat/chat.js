
// save messages

function onSaveSuccess(res) {
     // TODO: put message in "conversation" queue -- or let that be taken care of by 'get'?
     $("#status").append('<p class="success">saved message: ' + res.success + '</p>');
}

function onMySaveError(res) {
     // TODO: whine to user
     $("#status").append('<p class="failure">failed to save message: ' + res.error + '</p>');
}

function onHttpSaveError(response) {
    // TODO: whine, give advice to user (i.e. enable javascript, check network, etc.)
    $("#status").append('<p class="failure">http request failed: ' + response + "</p>");
}

function saveMessage(username, room, text) {
    var request = $.post( 'chat.php', 
            {'username': username,
             'room': room,
             'text': text,
             'type': 'savemessage'}, 
            function (response) {
                 var res = JSON.parse(response); //error: no parse ????
                 if("error" in res) {
                     onMySaveError(res);
                 } else {
                     onSaveSuccess(res);
                 }
            }
    );
    request.error(onHttpSaveError);
}

/*********************************************************************************/
// get all messages

function onGetSuccess(response) {
    $("#messagehistory").empty();
    for(var i = 0; i < response.messages.length; i++) {
        var m = response.messages[i];
        $("#messagehistory").append('<div><sub>time: ' + m.time + 
                                    'user: ' + m.username + '</sub>' + 
                                    '<div class="message">' + m.text + 
                                      '</div></div>');
    }
    $("#status").append('<p class="success">get messages succeeded, got ' + 
    		            response.messages.length + ' messages</p>');
}

function onGetFailure(message, response) {
	$("#status").append('<p class="failure">get messages failed: ' + 
			            message + "  " + response + "</p>");
}

function getAllMessages(room, onFailure) {
    var request = $.get('chat.php',
            {'type': 'getallmessages', 'room': room},
            function (response) {
                try {
                    var res = JSON.parse(response);
                    if("error" in res) {
                        onGetFailure('failed to retrieve all messages', res);
                    } else {
                        onGetSuccess(res);
                    }
                } catch(e) {// if the json parse fails
                    onGetFailure(e, response);//should I extract the message from e?
                }
            }
    );
    request.error = function(resp) {onGetFailure("http request failed", resp);};
}


/*********************************************************************************/
// get some messages

function getMessagesSince(room, time) {
    
}
