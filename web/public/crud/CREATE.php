<?php
    require_once "../dbconn.php";
    $conn = getDbConnection("crud");

    $content = $_POST["content"];
    $sql = "INSERT INTO tweets SET content='{$_POST["content"]}'";

    $result = $conn->query($sql);

    // Dice al browser di caricare la pagina 'index.php'
    header("Location: index.php");
?>

<!-- Crea un nuovo tweet -->