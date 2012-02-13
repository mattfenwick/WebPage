
function saveMessage(username, room, text) {
    var request = $.post( 'chat.php', 
            {'username': username,
    	     'room': room,
    	     'text': text,
    	     'type': 'savemessage'}, 
            function (response) {
                 var res = JSON.parse(response); //error: no parse ????
                 if("error" in res) {
                	 // don't put message in "conversation" queue, log error, whine to user
                	 alert("failed: " + res.error);
                 } else {
                	 // put message in "conversation" queue
                	 // change dialogs to jqueryui
                	 // "log" the success
                	 alert("success: " + response);
                 }
            }
    );
    
    request.error(function(resp) {
        alert("http savemessage request failed: " + resp);
    });
}


function getAllMessages(room, onSuccess) {
	var request = $.get('chat.php',
			{'type': 'getallmessages', 'room': room},
			function (response) {
				var res = JSON.parse(response);
				if("error" in res) {
					alert('failed to retrieve all messages: ' + res.error);
				} else {
					onSuccess(res);
				}
			}
	);
	
	request.error = function(response) {
        alert("http getallmessages request failed: " + resp);
	};
}


function getMessagesSince(room, time) {
	
}