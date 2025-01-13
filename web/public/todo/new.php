<!DOCTYPE html>

<html>

<head>
    <title>Crea un nuovo todo</title>
</head>

<body>
    <form action="/todo/actions/create.php" method="POST">
        <label for="todo-title">Scrivi qualcosa:</label><br />
        <input id="todo-title" name="title" type="text"><br />

        <button id="form-submit">Crea</button>
    </form>
</body>

</html>