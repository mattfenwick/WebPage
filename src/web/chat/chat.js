
// save messages

function onSaveSuccess(res) {
     // TODO: put message in "conversation" queue -- or let that be taken care of by 'get'?
     $("#status").append('<p class="success">saved message: ' + res.success + '</p>');
     $("#text").val("");// empty the text area if the message is saved
}

function onMySaveError(res) {
     // TODO: whine to user
     $("#status").append('<p class="failure">failed to save message: ' + res.error + '</p>');
}

function onHttpSaveError(response) {
    // TODO: whine, give advice to user (i.e. enable javascript, check network, etc.)
    $("#status").append('<p class="failure">http save request failed: ' + response + "</p>");
}

function onSaveResponse(res) {
    if("error" in res) {
        onMySaveError(res);
    } else {
        onSaveSuccess(res);
    }
}

function saveMessage(username, room, text) {
    var request = $.ajax({
            url:       'chat.php', 
            type:      'POST',
            dataType:  'json',
            data:      {'username': username,
                        'room': room,
                        'text': text,
                        'type': 'savemessage'},
            success:    onSaveResponse,
            error:     onHttpSaveError,
            timeout:   2000 // is this long enough?
    });
}

/*********************************************************************************/
// get all messages

function messageTemplate(time, username, text) {
    var myHTML = '<div><span class="time">time: ' + time + 
      '</span><span class="username">' + 'user: ' +
      username + '</span>' + '<div class="message">' + 
      text + '</div></div>';
    return myHTML;
}

function onGetSuccess(response) {
    $("#messagehistory").empty();
    for(var i = 0; i < response.messages.length; i++) {
        var m = response.messages[i];
        $("#messagehistory").append(messageTemplate(m.time, m.username, m.text));
    }
    $("#status").append('<p class="success">get messages succeeded, got ' + 
                        response.messages.length + ' messages</p>');
}

function onGetFailure(message, response) {
    $("#status").append('<p class="failure">get messages failed: ' + 
                        message + "  " + response + "</p>");
}

function onGetResponse(res) {
    if ("success" in res){
        onGetSuccess(res);
    } else {
        onGetFailure("received invalid response", res.error); // does it have error key?
    }
}

function getAllMessages(room) {
    var request = $.ajax({
            url:       'chat.php',
            type:      'GET',
            dataType:  'json',
            data:      {'type': 'getallmessages', 'room': room},
            success:   onGetResponse,
            timeout:   2000, // is this long enough?
            error:     function(resp, message) {
                onGetFailure("http request failed: " + message, resp);
            }
    }); 
}


/*********************************************************************************/
// get some messages

function getMessagesSince(room, time) {
    
}
