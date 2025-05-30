<?php
/* per creare il db usa questa query
CREATE DATABASE todo;
USE todo;
CREATE TABLE todos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(128) NOT NULL
);
*/

require_once '../../dbconn.php';
$conn = getDbConnection("todo");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $content = $_POST["content"];
  $sql = "INSERT INTO todos SET content = ?";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("s", $content);
  $stmt->execute();
}

$todos = $conn->query("SELECT * FROM todos");
?>

<!DOCTYPE html>

<html>

<head>
  <title>Login</title>
</head>

<body>
  <form action="index.php" method="POST">
    <label for="form-todo">Inserisci un TODO</label><br />
    <input id="form-todo" name="content" type="text"><br />
    <button id="form-submit">Salva</button>
  </form>

  <br/>

  <ul>
    <?php
      while ($todo = $todos->fetch_assoc()) {
        echo "<li>".$todo["content"]."</li>";
      }
    ?>
  </ul>
  <br/>

  <div>
    Per effettuare un'attacco XSS prova ad inserire nel
    TODO:<br/>
    <pre>todo infetto&lt;script&gt;alert("u hav been hakd");&lt;/script&gt;</pre>
  </div>
</body>

</html>