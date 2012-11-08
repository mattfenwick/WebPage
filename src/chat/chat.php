<?php

include_once('../../first.php');


function saveMessage($username, $room, $text, $db) {
    if(strlen($username) == 0 || strlen($room) == 0 || strlen($text) == 0) {
       return array('status' => 'error', 'message' => 'username, room or text was empty');
    }

    $stmt = $db->prepare('
        INSERT INTO messages
        (username, room, text)
        VALUES (?, ?, ?)
    ');
    
    if(!$stmt) {
        return array('status' => 'error', 'message' => 'unable to prepare db statement');
    }
    
    if($stmt->execute(array($username, $room, $text))) {
        return array('status' => 'success', 'message' => 'message added to db');
    } else {
        return array('status' => 'error', 'message' => 'unable to add message to db');
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
        return array('status' => 'error', 'message' => 'unable to prepare db statement');
    }
    
    if($stmt->execute(array($room))) {
        $messages = array();
        while($row = $stmt->fetch()) {
            array_push($messages, array('id' => $row['id'],
                                        'username' => stripslashes($row['username']),
                                        'room'     => stripslashes($row['room']),
                                        'text'     => stripslashes($row['text']),
                                        'time'     => $row['time']));
        }
        return array('status' => 'success', 'message' => 'fetched messages', 'messages' => $messages);
    } else {
        return array('status' => 'error', 'message' => 'unable to fetch messages from db');
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
        return array('status' => 'error', 'message' => 'unable to prepare db statement');
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
        return array('status' => 'success', 'message' => 'fetched messages', 'messages' => $messages);
    } else {
        return array('status' => 'error', 'message' => 'unable to fetch messages from db');
    } 
}


$type = $_REQUEST['type'];

$response = ""; // do I need to forward-declare it?? in php ??
$dbcon = getPDOConnection();

if(!$dbcon) {
    echo(json_encode(array('status' => 'error', 'message' => 'unable to connect to db')));
    die();
}

if($type == 'savemessage') {
    // use array_key_exists to check if the key is in the array!!!!
    $response = saveMessage($_POST['username'], $_POST['room'], 
                            $_POST['text'], $dbcon);
} else if($type == getallmessages) {
    $response = getAllMessages($_GET['room'], $dbcon);
} else if($type == 'getmessagessince') {
    $response = getMessagesSince($_GET['room'], $_GET['time'], $dbcon);
} else {
    $response = array('status' => 'error', 'message' => 'invalid request type');
}

echo(json_encode($response));

?>
