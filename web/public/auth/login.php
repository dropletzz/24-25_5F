<!DOCTYPE html>

<html>

<head>
  <title>Login</title>
</head>

<body>
    <?php if (isset($_GET['error'])): ?>
    <div style="border: 1px solid red; margin: 10px; padding: 10px;">
        <?= $_GET['error'] ?>
    </div>
    <?php endif; ?>

    <form action="login-utente.php" method="POST">
        <label>Inserisci email</label><br />
        <input name="email" type="text"><br />

        <label>Inserisci password</label><br />
        <input name="password" type="password"><br />

        <button id="form-submit">Invia</button>
    </form>
</body>

</html>
