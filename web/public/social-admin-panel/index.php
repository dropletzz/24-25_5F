<?php

require_once './model.php';

$totali = getTotali();



// Ultimi 5 utenti registrati
$utenti = $conn->query("SELECT * FROM users ORDER BY created_at DESC LIMIT 5");

// 10 post piu' popolari (con piu' like)
$post_popolari = $conn->query("
    SELECT users.id AS user_id, users.first_name, users.last_name, posts.created_at, posts.description,             COUNT(*) AS likes FROM posts
    JOIN post_likes ON posts.id = post_likes.post_id
    JOIN users ON users.id = posts.user_id
    GROUP BY posts.id
    ORDER BY likes DESC
    LIMIT 10;
");

function formatDate($date_str) {
    $time = strtotime($date_str);
    return date('d-m-Y', $time);
}
?>

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
                    <span><?= $tot_utenti ?></span>
                </div>
                <div>
                    Utenti registrati nell'ultima settimana:<br/>
                    <span><?= $tot_utenti_sett ?></span>
                </div>
            </div>
            <hr>
            <h2>Ultimi 5 utenti iscritti:</h2>
            <ul>
                <?php while ($u = $utenti->fetch_assoc()): ?>
                <li class="utente">
                    <div class="info">
                        <?= $u['first_name'] ?> <?= $u['last_name'] ?> (<?= $u['email'] ?>)
                    </div>
                    <div class="data-registrazione">

                        registrato il <?= formatDate($u['created_at']) ?>
                    </div>
                    <div class="link">
                        <a href="utente.php?id=<?= $u['id'] ?>">dettagli</a>
                    </div>
                </li>
                <?php endwhile; ?>
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
                <?php while ($p = $post_popolari->fetch_assoc()): ?>
                <li class="post">
                    <div class="content">
                        <?= $p['description'] ?>
                    </div>
                    <div class="likes">
                        <?= $p['likes'] ?>
                    </div>
                    <div class="info">
                        pubblicato il <?= formatDate($p['created_at']) ?>
                        da <a href="utente.php?id=<?= $p['user_id'] ?>"><?= $p['first_name'] . " " . $p['last_name'] ?></a>
                    </div>
                </li>
                <?php endwhile; ?>
            </ul>
        </div>

    </div>
</body>
</html>
