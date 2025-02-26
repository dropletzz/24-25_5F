<?php
require_once '../dbconn.php';

$conn = getDbConnection('social');

function getTotali() {
    global $conn;
    // Totale utenti
    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM users");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_utenti = $row['conteggio'];

    // Totale utenti registrati nell'ultima settimana
    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM users WHERE DATEDIFF(NOW(), created_at) <= 7");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_utenti_sett = $row['conteggio'];

    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM posts");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_post = $row['conteggio'];

    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM post_likes");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_like_post = $row['conteggio'];

    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM comments");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_commenti = $row['conteggio'];

    $result = $conn->query("SELECT COUNT(*) AS conteggio FROM comment_likes");
    $row = $result->fetch_assoc(); // tiro fuori la prima riga dal risultato della query
    $tot_like_commenti = $row['conteggio'];

    return array(
        "utenti" => $tot_utenti,
        "utenti_sett" => $tot_utenti_sett,
        "post" => $tot_post,
        "like" => $tot_like_post,
        "commenti" => $tot_like_commenti,
    );
}

function getUtenti() {
    global $conn;
    return $conn->query("SELECT * FROM users");
}
function getUltimiUtentiRegistrati() {
    global $conn;
    return $conn->query("SELECT * FROM users ORDER BY created_at DESC LIMIT 5");
}

// 10 post piu' popolari (con piu' like)
function getPostPopolari() {
    global $conn;
    return $conn->query("
        SELECT users.id AS user_id, users.first_name, users.last_name, posts.created_at, posts.description,             COUNT(*) AS likes FROM posts
        JOIN post_likes ON posts.id = post_likes.post_id
        JOIN users ON users.id = posts.user_id
        GROUP BY posts.id
        ORDER BY likes DESC
        LIMIT 10;
    ");
}

function ricercaUtenti($search) {
    global $conn;
    $search = "%".$search."%";
    $statement = $conn->prepare("
        SELECT * FROM users
        WHERE first_name LIKE ? OR last_name LIKE ? OR email LIKE ?
    ");
    $statement->bind_param("sss", $search, $search, $search);
    $statement->execute();
    return $statement->get_result();
}

function getUtente($user_id) {
    global $conn;
    $statement = $conn->prepare("SELECT * FROM users WHERE id = ?");
    $statement->bind_param("i", $user_id);
    $statement->execute();
    $result = $statement->get_result();
    return $result->fetch_assoc();
}


?>