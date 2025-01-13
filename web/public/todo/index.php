<?php
    require_once 'dbconn.php';
    $conn = getDbConnection('todolist');
    $result = $conn->query('SELECT * FROM todo');
    $conn->close();
?>

<html>

<head>
    <style>
        .todo-element {
            border-top: 1px solid black;
            padding: 10px;
            font-size: 18px;
        }
        .todo-element:last-child {
            border-bottom: 1px solid black;
        }

        .actions {
            text-align: right;
        }

        .todo-done {
            text-decoration: line-through;
            color: #999999;
        }
    </style>
</head>

<body>
    <div class="title">
        <a href="new.php">Crea nuovo</a>
        <h1>Cose da fare:</h1>
    </div>
    <div>
        <?php if ($result->num_rows > 0): ?>
            <?php while ($todo = $result->fetch_assoc()): ?>
                <!-- un singolo TODO -->
                <div class="todo-element">
                    
                    <!-- aggiunge la classe "todo-done" se il TODO e' stato fatto -->
                    <h3 class="<?= $todo['done'] ? "todo-done" : "" ?>">
                        <?= $todo['title'] ?>
                    </h3>

                    <div class="actions">
                        <a href="edit.php?id=<?= $todo['id'] ?>">modifica</a>
                        <span> | </span>
                        <a href="actions/delete.php?id=<?= $todo['id'] ?>">elimina</a>
                    </div>
                </div>
            <?php endwhile; ?>
        <?php endif; ?>
    </div>
</body>

</html>