<!DOCTYPE html>

<html>

<head>
    <title>Area riservata</title>
</head>

<body>

    <?php
    require_once '../../dbconn.php';
    $conn = getDbConnection("social");

    $email = $_POST["email"];
    // il login, per semplicita', controlla
    // solo che esista la mail dell'utente nel db
    $sql = "SELECT * FROM users WHERE email = '{$email}';";
    // !!! SQL injection !!!
    // l'email scritta dall'utente viene inserita
    // direttamente nella query SQL, senza nessun controllo

    $conn->multi_query($sql);
    // usare multi_query invece che query rende la vulnerabilita'
    // ancora piu' grave perche' permette di eseguire diverse
    // query separate da ';'

    $result = $conn->store_result();

    if ($result->num_rows > 0) {
        echo "<h1>Login effettuato con successo</h1>";
    } else {
        echo "<h1>Login non riuscito ):</h1>";
    }

    echo "<h3>Query eseguita:</h3>";
    echo "<pre>$sql</pre>";

    $conn->close();
    ?>
</body>

</html>