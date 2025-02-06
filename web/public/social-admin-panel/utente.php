<?php

if (!isset($_GET['id'])) {
    http_response_code(404);
    return;
}

require_once '../dbconn.php';
$conn = getDbConnection('social');

$user_id = $_GET['id'];
$statement = $conn->prepare("SELECT * FROM users WHERE id = ?");
$statement->bind_param("i", $user_id);
$statement->execute();

$result = $statement->get_result();
$user = $result->fetch_assoc();

?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Pagina utente</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php">Home</a> | 
        <a href="gestione-utenti.php">Gestione utenti</a>
    </nav>

    <h1 class="titolo">Pagina utente <?= $user['email'] ?></h1>
    
    <div class="contenitore">
        <!-- Visualizzare le seguenti info: -->
        <!-- * Nome, cognome, mail dell'utente -->
        <!-- * Totale dei post fatti -->
        <!-- * Totale dei like ricevuti -->
        <!-- * Elenco dei 5 post piu' popolari -->
    </div>
    </div>
</body>
</html>
