<?php

class Model {
    public $conn;
    public $dbname = 'images_spa';
    
    function __construct($dbname) {
        $this->dbname = $dbname;
        $this->conn = getDbConnection($this->dbname);
    }

    function getImage($id) {
        $stmt = $this->conn->prepare("SELECT * FROM images WHERE id = ?");
        $stmt->bind_param("i", $id);
        $stmt->execute();
        $result = $stmt->get_result();
        return $result->fetch_assoc();
    }

    function getImages() {
        $query_result = $this->conn->query("SELECT * FROM images");
        $images = $query_result->fetch_all(MYSQLI_ASSOC);
        return $images;
    }

    function insertImage($img) {
        $stmt = $this->conn->prepare("INSERT INTO images (url, description, rating) VALUES (?, ?, ?)");
        $stmt->bind_param("ssi", $img['image_url'], $img['description'], $img['rating']);
        return $stmt->execute();
    }

    function updateImage($id, $img) {
        $stmt = $this->conn->prepare("UPDATE images SET url = ?, description = ?, rating = ? WHERE id = ?");
        $stmt->bind_param("ssii", $img['image_url'], $img['description'], $img['rating'], $id);
        return $stmt->execute();
    }

    function deleteImage($id) {
        $stmt = $this->conn->prepare("DELETE FROM images WHERE id = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute() && $stmt->affected_rows > 0;
    }

    function deleteAllImages() {
        $stmt = $this->conn->prepare("DELETE FROM images");
        return $stmt->execute();
    }
}

function getDbConnection($dbname) {
    $servername = $_ENV['DB_HOST'] ?? 'localhost';
    $username = 'root';
    $password = '';

    // provo a connettermi al db
    $conn = new mysqli($servername, $username, $password, $dbname);

    // se non riesco a connettermi, termino l'esecuzione
    if ($conn->connect_error) {
        die('Connection failed: ' . $conn->connect_error);
    }

    return $conn;
}

?>