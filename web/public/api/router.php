<?php

require_once '../dbconn.php';
$conn = getDbConnection('images_spa');

$request = array(
    'method' => $_SERVER['REQUEST_METHOD'],
    'uri'    => $_SERVER['REQUEST_URI'],
    'body'   => file_get_contents('php://input'),
);
$params = [];

// tutte le risposte saranno in formato JSON
header('Content-Type: application/json');

// trasforma un'immagine presa dal database in un'immagine delle API REST
function map_image($db_image) {
    return [
        "id" => intval($db_image['id']),
        "image_url" => $db_image['url'],
        "rating" => intval($db_image['rating']),
        "description" => $db_image['description']
    ];
};

// controlla che l'immagine REST contenga tutti i campi obbligatori
function validate_image($rest_image) {
    if (!isset($rest_image['image_url']) || !isset($rest_image['rating'])) {
        http_response_code(400);
        echo json_encode(["error" => "Parametri mancanti o non validi."]);
        exit;
    }
};


// INIZIO --  GESTIONE DELLE RICHIESTE HTTP
if (req_is("GET", "/api/images")) {
    $query_result = $conn->query("SELECT * FROM images");
    $images = $query_result->fetch_all(MYSQLI_ASSOC);
    if (sizeof($images) == 0) {
        http_response_code(204);
        exit;
    }
    $response_body = array_map('map_image', $images);
    echo json_encode($response_body);
}
else if (req_is("POST", "/api/images")) {
    $req_body = json_decode($request['body'], true);
    validate_image($req_body);
    $stmt = $conn->prepare("INSERT INTO images (url, description, rating) VALUES (?, ?, ?)");
    $stmt->bind_param("ssi", $req_body['image_url'], $req_body['description'], $req_body['rating']);
    $stmt->execute();
    http_response_code(201);
    echo json_encode([
        "id" => $conn->insert_id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
}
else if (req_is("GET", "/api/images/:id")) {
    $id = $params[0];
    $stmt = $conn->prepare("SELECT * FROM images WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $image = $result->fetch_assoc();
    if ($image) {
        http_response_code(200);
        echo json_encode($map_image($image));
    } else {
        http_response_code(404);
        echo json_encode(["error" => "Immagine non trovata."]);
    }
}
else if (req_is("PUT", "/api/images/:id")) {
    $id = $params[0];
    $req_body = json_decode($request['body'], true);
    validate_image($req_body);
    $stmt = $conn->prepare("UPDATE images SET url = ?, description = ?, rating = ? WHERE id = ?");
    $stmt->bind_param("ssii", $req_body['image_url'], $req_body['description'], $req_body['rating'], $id);
    $stmt->execute();
    echo json_encode([
        "id" => $id,
        "url" => $req_body['image_url'],
        "description" => $req_body['description'],
        "rating" => $req_body['rating']
    ]);
}
else if (req_is("DELETE", "/api/images/:id")) {
    $id = $params[0];
    $stmt = $conn->prepare("DELETE FROM images WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
        http_response_code(204);
    }
    else {
        http_response_code(404);
        echo json_encode(["error" => "Immagine non trovata."]);
    }
}
else {
    http_response_code(404);
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
?>
