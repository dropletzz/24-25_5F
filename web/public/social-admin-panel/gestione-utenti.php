<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione utenti</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php">Home</a> | 
        <a href="gestione-utenti.php">Gestione utenti</a>
    </nav>

    <h1 class="titolo">Gestione utenti</h1>
    
    <div class="contenitore">
        <form class="barra-di-ricerca" action="gestione-utenti.php" method="GET">
            <input name="search" type="text">
            <button>Cerca</button>
        </form>

        <table border="1">
            <tr>
                <th>Nome</th>
                <th>Cognome</th>
                <th>Email</th>
                <th>Data di registrazione</th>
                <th></th>
            </tr>
            <tr>
                <td>Mario</td>
                <td>Rossi</td>
                <td>rmario@inwind.it</td>
                <td>23/08/2023</td>
                <td><a href="utente.php?id=37">dettagli</a></th>
            </tr>
            <tr>
                <td>Mario</td>
                <td>Rossi</td>
                <td>rmario@inwind.it</td>
                <td>23/08/2023</td>
                <td><a href="utente.php?id=37">dettagli</a></th>
            </tr>
            <tr>
                <td>Mario</td>
                <td>Rossi</td>
                <td>rmario@inwind.it</td>
                <td>23/08/2023</td>
                <td><a href="utente.php?id=37">dettagli</a></th>
            </tr>
        </table>
    </div>
    </div>
</body>
</html>
