<!DOCTYPE html>

<html>

<head>
    <title>Area riservata</title>
</head>

<body>

    <?php
    require_once '../dbconn.php';
    $conn = getDbConnection("social");

    // !!! Vulnerabile a SQL injection !!!
    $email = $_POST["email"];
    $sql = "SELECT * FROM users WHERE email = '{$email}';";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "Login effettuato con successo";
    } else {
        echo "Login non riuscito ):";
    }

    $conn->close();
    ?>
</body>

</html>