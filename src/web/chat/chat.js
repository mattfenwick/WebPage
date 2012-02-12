
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
                	 alert("success: " + response);
                 }
            }
    );
    
    request.error(function(resp) {
        alert("ajax request failed: " + resp);
    });
}


function getAllMessages(room) {
	var request = $.get('/chat.php',
			{'type': 'getallmessages', 'room': room},
			function (response) {
				var res = JSON.parse(response);
				if("error" in res) {
					
				} else {
					
				}
			}
	);
	
	request.error = function(response) {
        alert("ajax request failed: " + resp);
	};
}


function getMessagesSince(room, time) {
	
}