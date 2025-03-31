<?php

class RoutesHandler {
    private $handlers;
    private $inject;
    
    function __construct($inject) {
        $this->handlers = [];
        $this->inject = $inject;
    }

    function mount(string $method, string $magic_path, callable $handler): RoutesHandler {
        if (isset($this->handlers[$method]))
            array_push($this->handlers[$method], [$magic_path, $handler]);
        else 
            $this->handlers[$method] = [[$magic_path, $handler]];
        return $this;
    }

    function handle(array $request): bool {
        $method = $request['method'];
        if (!isset($this->handlers[$method])) return false;

        foreach ($this->handlers[$method] as $pair) {
            $magic_path = $pair[0];
            $handler = $pair[1];
            $params = RoutesHandler::path_match($request['path'], $magic_path);
            if ($params) return $handler($request, $params, $this->inject);
        }

        return false;
    }

    function with_prefix(string $path_prefix): PrefixedRoutesMounter {
        return new PrefixedRoutesMounter($this, $path_prefix);
    }


    // Confronta il percorso effettivo di una richiesta ($path)
    // con le rotte parametriche ($magic_path).
    // TODO esempio di utilizzo
    private static function path_match(string $path, string $magic_path): array | null {
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
        $regex = "/^$regex(:?(:?\?[^\?]*)|\/?)?$/";

        // faccio il match con la regex
        $matches = [];
        $ok = preg_match($regex, $path, $matches);
        if (!$ok) return null;

        foreach ($matches as $i => $match) {
            if ($i > 0) array_push($params, $match);
        }
        return $params;
    }
}

class PrefixedRoutesMounter {
    private RoutesHandler $routes;
    private string $prefix;

    function __construct(RoutesHandler $routes, string $prefix) {
        $this->routes = $routes;
        $this->prefix = $prefix;
    }

    function mount(string $method, string $magic_path, callable $handler): PrefixedRoutesMounter {
        $new_path = $this->prefix.$magic_path;
        $this->routes->mount($method, $new_path, $handler);
        return $this;
    }
}

?>