<!-- Pagina HTML che mostra tutti i tweet -->

<!DOCTYPE html>

<html>

<head>
    <title>Elenco dei tweet</title>
</head>

<body>

    <div>
        <a href="new.php">Crea un nuovo tweet</a>
    </div>

    <?php
    require_once "../dbconn.php";
    $conn = getDbConnection("crud");

    $sql = "SELECT * FROM tweets";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // output data of each row
        while ($row = $result->fetch_assoc()) {
            echo $row['content'];
            $href = 'DELETE.php?id=' . $row["id"];
            echo '<a href="' . $href . '" style="float: right">elimina</a>';
            echo "<hr>";
        }
    } else {
        echo "Nessun tweet";
    }
    ?>
</body>

</html>