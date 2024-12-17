<!DOCTYPE html>

<html>

<head>
  <title>Connessione a un database</title>
</head>

<body>

  <div class="contenitore">
    <?php
    $servername = "database";
    $username = "root";
    $password = "";
    $dbname = "social";

    // Creo Connessione
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Controllo Connessione
    if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
    }

    $sql = "SELECT id, email, first_name, last_name FROM users";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
      // output data of each row
      echo "<table>";
      while ($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>{$row["id"]}</td>";
        echo "<td>{$row["email"]}</td>";
        echo "<td>{$row["first_name"]}</td>";
        echo "<td>{$row["last_name"]}</td>";
        echo "</tr>";
      }
      echo "</table>";
    } else {
      echo "Nessun utente nel db";
    }
    $conn->close();
    ?>
  </div>
</body>

</html>