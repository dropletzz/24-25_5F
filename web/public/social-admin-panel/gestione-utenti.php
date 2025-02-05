<?php
require '../dbconn.php';

$conn = getDbConnection('social');


if (isset($_GET['search'])) {
    $search = "%".$_GET['search']."%";
    $statement = $conn->prepare("
        SELECT * FROM users
        WHERE first_name LIKE ? OR last_name LIKE ? OR email LIKE ?
    ");
    $statement->bind_param("sss", $search, $search, $search);
    $statement->execute();
    $utenti = $statement->get_result();
}
else {   
    // Totale utenti
    $utenti = $conn->query("SELECT * FROM users");
}

?>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione utenti</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php">Home</a> | 
        <a href="gestione-utenti.php">Gestione utenti</a>
    </nav>

    <h1 class="titolo">Gestione utenti</h1>
    
    <div class="contenitore">
        <form class="barra-di-ricerca" action="gestione-utenti.php" method="GET">
            <input name="search" type="text">
            <button>Cerca</button>
        </form>

        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Email</th>
                <th>Data di registrazione</th>
                <th></th>
            </tr>
            <?php while ($u = $utenti->fetch_assoc()): ?>
                <tr>
                    <td><?= $u['first_name'] ?></td>
                    <td><?= $u['last_name'] ?></td>
                    <td><?= $u['email'] ?></td>
                    <td><?= $u['created_at'] ?></td>
                    <td><a href="utente.php?id=<?= $u['id'] ?>">dettagli</a></th>
                </tr>
            <?php endwhile; ?> 
        </table>
    </div>
    </div>
</body>
</html>
