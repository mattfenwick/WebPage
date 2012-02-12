<?php

include_once('../first.php');


function saveMessage($username, $room, $text, $time, $db) {
    $stmt = $db->prepare('
        INSERT INTO messages
        (username, room, text, time)
        VALUES (?, ?, ?, from_unixtime(?))
    ');
    
    if(!$stmt) {
        return array('error' => 'unable to prepare db statement');
    }
    
    if($stmt->execute(array($username, $room, $text, $time))) {
        return array('success' => 'message added to db');
    } else {
        return array('error' => 'unable to add message to db');
    }
}


function getAllMessages($room, $db) {
    $stmt = $db->prepare('
        SELECT id, username, room, text, time 
        FROM messages
        WHERE room = ?
        ORDER BY time
    ');
    
    if(!$stmt) {
        return array('error' => 'unable to prepare db statement');
    }
    
    if($stmt->execute(array($room))) {
        $messages = array();
        while($row = $stmt->fetch()) {
            array_push($messages, array('id' => $row['id'],
                                        'username' => $row['username'],
                                        'room'     => $row['room'],
                                        'text'     => $row['text'],
                                        'time'     => $row['time']));
        }
        return $messages;
    } else {
        return array('error' => 'unable to fetch messages from db');
    }    
}


function getMessagesSince($room, $time, $db) {
    $stmt = $db->prepare('
        SELECT id, username, room, text, time 
        FROM messages
        WHERE room = ?  AND time > ?
        ORDER BY time
    ');
    
    if(!$stmt) {
        return array('error' => 'unable to prepare db statement');
    }
    
    if($stmt->execute(array($room, $time))) {
        $messages = array();
        while($row = $stmt->fetch()) {
            array_push($messages, array('id' => $row['id'],
                                        'username' => $row['username'],
                                        'room'     => $row['room'],
                                        'text'     => $row['text'],
                                        'time'     => $row['time']));
        }
        return $messages;
    } else {
        return array('error' => 'unable to fetch messages from db');
    } 
}


$type = $_REQUEST['type'];

$response = ""; // do I need to forward-declare it?? in php ??
$dbcon = getPDOConnection();

if(!$dbcon) {
    echo(json_encode(array('error' => 'unable to connect to db')));
}

if($type == 'savemessage') {
    // use array_key_exists to check if the key is in the array!!!!
    $response = saveMessage($_POST['username'], $_POST['room'], 
                            $_POST['text'], $_POST['time'], $dbcon);
} else if($type == getallmessages) {
    $response = getAllMessages($_GET['room'], $dbcon);
} else if($type == 'getmessagessince') {
    $response = getMessagesSince($_GET['room'], $_GET['time'], $dbcon);
} else {
    $response = array('error' => 'invalid request type');
}

echo(json_encode($response));

?>
