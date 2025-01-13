<?php
    require_once 'dbconn.php';
    $id = $_GET['id'];

    $conn = getDbConnection('todolist');
    $sql = "SELECT * FROM todo WHERE id={$id}";

    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $todo = $result->fetch_assoc();
        $title = $todo['title'];
    }

    $conn->close();
?>

<!DOCTYPE html>

<html>

<head>
    <title>Modifica un todo</title>
</head>

<body>
    <form action="/todo/actions/update.php" method="POST">
        <input id="todo-title" name="id" type="hidden" value="<?= $id ?>"><br />

        <label for="todo-title">Scrivi qualcosa:</label><br />
        <input id="todo-title" name="title" type="text" value="<?= $title ?>"><br />

        <button id="form-submit">Crea</button>
    </form>
</body>

</html>