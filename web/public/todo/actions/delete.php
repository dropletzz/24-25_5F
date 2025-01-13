<?php
    require_once '../dbconn.php';
    $id = $_GET['id'];

    $conn = getDbConnection('todolist');
    $sql = "DELETE FROM todo WHERE id={$id}";

    $result = $conn->query($sql);
    $conn->close();

    // Dice al browser di caricare la pagina 'index.php'
    header('Location: ../index.php');
?>

<!-- Cancella un todo dato il suo id -->