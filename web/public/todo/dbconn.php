<?php
function getDbConnection($dbname) {
    $servername = 'database';
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
