<?php

$request = array(
    'method' => $_SERVER['REQUEST_METHOD'],
    'uri'    => $_SERVER['REQUEST_URI'],
    'body'   => file_get_contents('php://input'),
);
$params = [];

// tutte le risposte saranno in formato JSON
header('Content-Type: application/json');

if (req_is("GET", "/api/cats")) {
    // SELECT tutti i gatti
}
else if (req_is("POST", "/api/cats")) {
    // INSERT nuovo gatto
}
else if (req_is("GET", "/api/cats/:id")) {
    // SELECT gatto
}
else if (req_is("PUT", "/api/cats/:id")) {
    // UPDATE gatto
}
else if (req_is("DELETE", "/api/cats/:id")) {
    // DELETE gatto
}
else {
    return http_response_code(404);
}

function req_is($method, $uri) {
    global $request;
    global $params;
    $params = [];

    if ($request['method'] != $method) return false;

    // costruisco la regex
    $regex = '';
    $words = explode('/', $uri); // "/api/cats/:id" diventa ["", "api", "cats", ":id"]
    foreach ($words as $i => $word) {
        if (str_starts_with($word, ':'))
            $regex = $regex . "\/([^\/]+)";
        else if ($word != '')
            $regex = $regex . "\/$word";
    }
    $regex = "/^$regex\/?$/";

    // faccio il match con la regex
    $matches = [];
    $ok = preg_match($regex, $request['uri'], $matches);
    foreach ($matches as $i => $match) {
        if ($i > 0) array_push($params, $match);
    }
    
    return $ok;
}
?>
