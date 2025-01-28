<?php
    require_once '../../dbconn.php';
    $title = $_POST['title'];

    $conn = getDbConnection('todolist');
    $sql = "INSERT INTO todo SET title='{$title}'";

    $result = $conn->query($sql);
    $conn->close();

    // Dice al browser di caricare la pagina 'index.php'
    header('Location: ../index.php');
?>

<!-- Crea un nuovo todo -->