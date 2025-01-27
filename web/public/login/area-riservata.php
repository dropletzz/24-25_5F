<!DOCTYPE html>

<html>

<head>
    <title>Area riservata</title>
</head>

<body>

    <?php
    require_once '../dbconn.php';
    $conn = getDbConnection("social");

    $sql = "SELECT * FROM users WHERE email = ?";

    // Per evitare vulnerabilita' SQL injection
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email); // "s" indica che $email e' una stringa
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "Login effettuato con successo";
    } else {
        echo "Login non riuscito ):";
    }

    $conn->close();
    ?>
</body>

</html>
