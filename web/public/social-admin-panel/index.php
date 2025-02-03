<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Pannello Amministrativo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav>
        <a href="index.php">Home</a> | 
        <a href="gestione-utenti.php">Gestione utenti</a>
    </nav>
    <div class="contenitore">
        <h1 class="titolo">Pannello amministrativo</h1>

        <div class="utenti pannello">
            <div class="totali">
                <div>
                    Totale utenti:<br/>
                    <span>77</span>
                </div>
                <div>
                    Utenti registrati nell'ultima settimana:<br/>
                    <span>10</span>
                </div>
            </div>
            <hr>
            <h2>Ultimi 5 utenti iscritti:</h2>
            <ul>
                <li class="utente">
                    <div class="info">
                        Tizio Caio (tiziocaio@libero.it)
                    </div>
                    <div class="data-registrazione">
                        registrato il 12/11/2024
                    </div>
                    <div class="link">
                        <a href="utente.php?id=37">dettagli</a>
                    </div>
                </li>
            </ul>
        </div>

        <div class="elenco-post pannello">
            <div class="totali">
                <div>
                    Totale dei post:<br/>
                    <span>112</span>
                </div>
                <div>
                    Totale dei commenti:<br/>
                    <span>347</span>
                </div>
                <div>
                    Totale dei like:<br/>
                    <span>1832</span>
                </div>
            </div>
            <hr>
            <h2>I 10 post più popolari:</h2>
            <ul>
                <li class="post">
                    <div class="content">
                        blablbasl llablal lbllas del post
                    </div>
                    <div class="likes">
                         49
                    </div>
                    <div class="info">
                        pubblicato il 01/02/2025
                        da <a href="utente.php?id=37">Mario Rossi</a>
                    </div>
                </li>
            </ul>
        </div>

    </div>
</body>
</html>
