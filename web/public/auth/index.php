<?php session_start() # da fare ogni volta che usiamo le sessioni ?>
<!DOCTYPE html>

<html>

<head>
  <title>Esempio autenticazione</title>
</head>

<body>
    <?php if (isset($_SESSION['email'])): # loggato ?>
        <div style="text-align: right;">
            Sei loggato come <?= $_SESSION['email'] ?>
            (<a href="logout.php">logout</a>)
        </div>
        <h1>Sei nella tua area riservata!</h1>
    <?php else: # non loggato ?>
        <p>Nuovo utente? <a href="registrazione.php">Registrati</a></p> 
        <p>Sei gia' registrato? <a href="login.php">Fai il login</a></p> 
    <?php endif; ?>
</body>

</html>
