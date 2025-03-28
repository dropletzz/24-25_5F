<?php

require_once 'model.php';
$dbname = 'images_spa';
// la classe Model gestisce tutte le interazioni col DB
$model = new Model($dbname);

// $request contiene i dati della richiesta HTTP
$request = array(
    'method' => $_SERVER['REQUEST_METHOD'],
    'uri'    => $_SERVER['REQUEST_URI'],
    'body'   => file_get_contents('php://input'),
);

// $params contiene eventuali parametri inseriti
// nell'URL della richiesta (si veda la funzione req_is)
$params = [];

// tutte le risposte saranno in formato JSON
header('Content-Type: application/json');

// INIZIO -- GESTIONE DELLE RICHIESTE HTTP
if (req_is("GET", "/api/images")) {
    $images = $model->getImages();
    if (sizeof($images) == 0) respond(204);
    $response_body = array_map('map_image', $images);
    respond(200, $response_body);
}
else if (req_is("POST", "/api/images")) {
    $req_body = json_decode($request['body'], true);

    if (!validate_image($req_body))
        respond(400, ["error" => "Parametri mancanti o non validi."]);

    $id = $model->insertImage($req_body);
    if (!$id) respond(400, ["error" => "Impossibile eseguire la query di inserimento"]);

    respond(201, [
        "id" => $id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
}
else if (req_is("GET", "/api/images/:id")) {
    $id = $params[0];
    $image = $model->getImage($id);
    if ($image) respond(200, map_image($image));
    else        respond(404, ["error" => "Immagine non trovata."]);
}
else if (req_is("PUT", "/api/images/:id")) {
    $id = $params[0];
    $req_body = json_decode($request['body'], true);

    if (!validate_image($req_body))
        respond(400, ["error" => "Parametri mancanti o non validi."]);

    if (!$model->updateImage($id, $req_body))
        respond(400, ["error" => "Impossibile eseguire la query di inserimento"]);

    respond(200, [
        "id" => $id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
}
else if (req_is("DELETE", "/api/images/:id")) {
    $id = $params[0];
    if ($model->deleteImage($id)) respond(204);
    else respond(404, ["error" => "Immagine non trovata."]);
}
else {
    respond(404);
}
// FINE -- GESTIONE DELLE RICHIESTE HTTP

// Funzione usata per identficare l'URL della richiesta
// ed eventualmente estrarre dei parametri dall'URL.
// I parametri iniziano con il carattere ':', ad esempio:
// req_is("GET", "/api/posts/:id") restituisce vero se 
// la richiesta e' GET /api/posts/123 e l'array globale
// $params conterra' il valore [123]
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
            $regex = $regex . "\/([^\/\?]+)";
        else if ($word != '')
            $regex = $regex . "\/$word";
    }
    $regex = "/^$regex(:?(:?\?[^\?]*)|\/)?$/";

    // faccio il match con la regex
    $matches = [];
    $ok = preg_match($regex, $request['uri'], $matches);
    foreach ($matches as $i => $match) {
        if ($i > 0) array_push($params, $match);
    }
    
    return $ok;
}

// trasforma un'immagine presa dal database in un'immagine delle API REST
function map_image($db_image) {
    return [
        "id" => intval($db_image['id']),
        "image_url" => $db_image['url'],
        "rating" => intval($db_image['rating']),
        "description" => $db_image['description']
    ];
}

// controlla che l'immagine REST contenga tutti i campi obbligatori
function validate_image($rest_image) {
    return isset($rest_image['image_url']) && isset($rest_image['rating']);
}

function respond($statusCode, $body = "") {
    http_response_code($statusCode);
    echo json_encode($body);
    exit;
}

?>
