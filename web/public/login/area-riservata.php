<!DOCTYPE html>

<html>

<head>
    <title>Area riservata</title>
</head>

<body>

    <?php
    $servername = "database";
    $username = "root";
    $password = "";
    $dbname = "social";

    // crea connessione
    $conn = new mysqli($servername, $username, $password, $dbname);
    // controlla connessione
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // !!! Rischio di SQL injection !!!
    $email = $_POST['email'];
    $sql = "SELECT * FROM users WHERE email = '{$email}';";
    echo "QUERY> " . $sql . "<br/>";

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