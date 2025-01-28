<?php
require_once '../dbconn.php';

$email = $_POST['email'];
$password = $_POST['password'];

$conn = getDbConnection('auth');
$sql = "SELECT * FROM users WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
$conn->close();

$user = $result->fetch_assoc();
if (!$user) {
    // se nel db non esiste un utente con la mail specificata
    // ricarico il form di login mostrando un errore
    $msg = urlencode("Login non riuscito, riprova");
    return header("Location: login.php?error=$msg");
}
// Confronto la password inserita con lo hash salvato sul database
$ok = password_verify($password, $user['password_hash']);
if ($ok) {
    header('Location: index.php?autenticato=1');
}
else {
    header('Location: index.php');
}
?>

