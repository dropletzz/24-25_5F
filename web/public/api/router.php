<?php

require_once 'Model.php';
require_once 'RoutesHandler.php';

$dbname = 'images_spa';
$model = new Model($dbname); // interazioni col DB
$routes = new RoutesHandler($model); // definizione delle API

// tutte le risposte saranno in formato JSON
header('Content-Type: application/json');

$routes->with_prefix("/api/images/")
->mount("GET", "",  function ($request, $params, $model) {
    $images = $model->getImages();
    if (sizeof($images) == 0) respond(204);
    $response_body = array_map('map_image', $images);
    respond(200, $response_body);
})
->mount("POST", "",  function ($request, $params, $model) {
    $req_body = json_decode($request['body'], true);

    if (!validate_image($req_body))
        respond(400, ["error" => "Parametri mancanti o non validi."]);

    $id = $model->insertImage($req_body);
    if ($id < 0) respond(400, ["error" => "Impossibile eseguire la query di inserimento"]);

    respond(201, [
        "id" => $id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
})
->mount("GET", ":id",  function ($request, $params, $model) {
    $id = $params[0];
    $image = $model->getImage($id);
    if ($image) respond(200, map_image($image));
    else        respond(404, ["error" => "Immagine non trovata."]);
})
->mount("PUT", ":id",  function ($request, $params, $model) {
    $id = $params[0];
    $req_body = json_decode($request['body'], true);

    if (!validate_image($req_body))
        respond(400, ["error" => "Parametri mancanti o non validi."]);

    if (!$model->updateImage($id, $req_body))
        respond(400, ["error" => "Impossibile eseguire la query di update"]);

    respond(200, [
        "id" => $id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
})
->mount("DELETE", ":id",  function ($request, $params, $model) {
    $id = $params[0];
    if ($model->deleteImage($id)) respond(204);
    else respond(404, ["error" => "Immagine non trovata."]);
});

// $request contiene i dati della richiesta HTTP
$request = array(
    'method' => $_SERVER['REQUEST_METHOD'],
    'path'    => $_SERVER['REQUEST_URI'],
    'body'   => file_get_contents('php://input'),
);

if (!$routes->handle($request)) respond(404);

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
