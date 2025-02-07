<?php
require_once '../dbconn.php';

$conn = getDbConnection('social');

function getTotali() {
    // Totale utenti
    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM users");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_utenti = $row['conteggio'];

    // Totale utenti registrati nell'ultima settimana
    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM users WHERE DATEDIFF(NOW(), created_at) <= 7");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_utenti_sett = $row['conteggio'];

    return array(
        "tot_utenti" => $tot_utenti,
        "tot_utenti_sett" => $tot_utenti_sett
    )
}

function getUtenti() {
    return $conn->query("SELECT * FROM users ORDER BY created_at DESC LIMIT 5");
}


// 10 post piu' popolari (con piu' like)
$post_popolari = $conn->query("
    SELECT users.id AS user_id, users.first_name, users.last_name, posts.created_at, posts.description,             COUNT(*) AS likes FROM posts
    JOIN post_likes ON posts.id = post_likes.post_id
    JOIN users ON users.id = posts.user_id
    GROUP BY posts.id
    ORDER BY likes DESC
    LIMIT 10;
");
?>