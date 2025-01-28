<!DOCTYPE html>

<html>

<head>
  <title>Esempio autenticazione</title>
</head>

<body>
    <?php if (isset($_GET['autenticato'])): ?>
        <h1>Benvenuto nella tua area riservata!</h1>
    <?php else: ?>
        <p>Nuovo utente? <a href="registrazione.html">Registrati</a></p> 
        <p>Sei gia' registrato? <a href="login.html">Fai il login</a></p> 
    <?php endif; ?>
</body>

</html>
