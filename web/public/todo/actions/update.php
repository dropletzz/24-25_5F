<?php
    require_once '../dbconn.php';
    $id = $_POST['id'];
    $title = $_POST['title'];

    $conn = getDbConnection('todolist');
    $sql = "UPDATE todo SET title='{$title}' WHERE id={$id}";

    $result = $conn->query($sql);
    $conn->close();

    // Dice al browser di caricare la pagina 'index.php'
    header('Location: ../index.php');
?>

<!-- Modifica il contenuto di un todo -->