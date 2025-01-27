<?php
require_once '../dbconn.php';

$email = $_POST['email'];
$name = $_POST['name'];
$surname = $_POST['surname'];
// Calcolo l'hash della password inserita
$hash = password_hash($_POST['password'], PASSWORD_DEFAULT);

$conn = getDbConnection('auth');
$sql = "INSERT INTO users SET email=?, password_hash=?, name=?, surname=?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssss", $email, $hash, $name, $surname);
$stmt->execute();
$result = $stmt->get_result();
$conn->close();

// Dice al browser di caricare la pagina 'index.php'
header('Location: index.php');
?>

