
<!DOCTYPE html>

<html>

<head>
  <title>Registrazione</title>
</head>

<body>
    <?php if (isset($_GET['error'])): ?>
    <div style="border: 1px solid red; margin: 10px; padding: 10px;">
        <?= $_GET['error'] ?>
    </div>
    <?php endif; ?>

    <form action="registra-utente.php" method="POST">
        <label>Inserisci email</label><br />
        <input name="email" type="text"><br />

        <label>Inserisci nome</label><br />
        <input name="name" type="text"><br />

        <label>Inserisci cognome</label><br />
        <input name="surname" type="text"><br />

        <label>Inserisci password</label><br />
        <input name="password" type="password"><br />

        <button>Invia</button>
    </form>
</body>

</html>
