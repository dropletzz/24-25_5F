<?php

class RoutesHandler {
    private $handlers;
    private $inject;
    
    function __construct($inject) {
        $this->handlers = [];
        $this->inject = $inject;
    }

    function add($method, $magic_path, $handler) {
        if (isset($this->handlers[$method]))
            array_push($this->handlers[$method], [$magic_path, $handler]);
        else 
            $this->handlers[$method] = [[$magic_path, $handler]];
    }

    function handle($request) {
        $method = $request['method'];
        if (!isset($this->handlers[$method])) return false;

        foreach ($this->handlers[$method] as $pair) {
            $magic_path = $pair[0];
            $handler = $pair[1];
            $params = path_match($request['path'], $magic_path);
            if ($params) return $handler($request, $params, $this->inject);
        }

        return false;
    }
};

// Funzione usata per identficare l'URL della richiesta
// ed eventualmente estrarre dei parametri dall'URL.
// I parametri iniziano con il carattere ':', ad esempio:
// req_is("GET", "/api/posts/:id") restituisce vero se 
// la richiesta e' GET /api/posts/123 e l'array globale
// $params conterra' il valore [123]
function path_match($path, $magic_path) {
    $params = [];

    // costruisco la regex
    $regex = '';
    $words = explode('/', $magic_path); // "/api/cats/:id" diventa ["", "api", "cats", ":id"]
    foreach ($words as $i => $word) {
        if (str_starts_with($word, ':'))
            $regex = $regex . "\/([^\/\?]+)";
        else if ($word != '')
            $regex = $regex . "\/$word";
    }
    $regex = "/^$regex(:?(:?\?[^\?]*)|\/)?$/";

    // faccio il match con la regex
    $matches = [];
    $ok = preg_match($regex, $path, $matches);
    if (!$ok) return null;

    foreach ($matches as $i => $match) {
        if ($i > 0) array_push($params, $match);
    }
    return $params;
}

?>