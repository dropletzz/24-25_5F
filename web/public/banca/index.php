<?php
require_once '../dbconn.php';

$conn = getDbConnection('banca');

function transferFunds($id_mittente, $id_destinatario, $importo) {
    global $conn;

    try {
        $conn->begin_transaction(); // inizia una transazione

        // sottrai importo dal saldo del mittente
        $sql = 'UPDATE conti SET saldo = saldo - ? WHERE id = ?';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("di", $importo, $id_mittente);
        $stmt->execute();

        if ($stmt->affected_rows != 1) {
            $conn->rollback(); // annulla la transizione
            return "Mittente sconosciuto";
        }

        $sql = 'SELECT * FROM conti WHERE id = ?';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id_mittente);
        $stmt->execute();
        $conto_mittente = $stmt->get_result()->fetch_assoc();

        // controlla che il mittente non sia andato in negativo
        if ($conto_mittente['saldo'] < 0) {
            $conn->rollback(); // annulla la transizione
            return "Fondi insufficienti";
        }

        // aggiungi importo al saldo del destinatario
        $sql = 'UPDATE conti SET saldo = saldo + ? WHERE id = ?';
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("di", $importo, $id_destinatario);
        $stmt->execute();
    
        if ($stmt->affected_rows != 1) {
            $conn->rollback(); // annulla la transizione
            return "Destinatario sconosciuto";
        }

        $conn->commit(); // termina la transazione e applica le query
        return null;
    }
    catch (Exception $e) {
        $conn->rollback(); // annulla la transizione
        return "Impossibile trasferire i fondi";
    }
}

$error_msg = null;
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_mittente = $_POST['id_mittente'];
    $id_destinatario = $_POST['id_destinatario'];
    $importo = $_POST['importo'];

    $error_msg = transferFunds($id_mittente, $id_destinatario, $importo);
}

$result = $conn->query('SELECT SUM(saldo) AS tot FROM conti');
$saldo = $result->fetch_assoc();

$result_conti = $conn->query('SELECT * FROM conti');
$conti = $result_conti->fetch_all(MYSQLI_ASSOC);

$conn->close();
?>

<html>
    <head>
        <title>banca</title>
    </head>
    <body>
        <? if ($error_msg): ?>
            <div style="border: 3px solid red; margin: 10px; padding: 5px;">
                <?= $error_msg ?>
            </div>
        <? endif; ?>

        <h2>Saldo totale: <?= $saldo['tot'] ?></h2>

        <table border="1">
            <tr>
                <th>id</th>
                <th>nome</th>
                <th>saldo</th>
            </tr>
            <?php foreach ($conti as $conto): ?>
                <tr>
                    <td><?= $conto['id'] ?></td>
                    <td><?= $conto['nome_utente'] ?></td>
                    <td><?= $conto['saldo'] ?></td>
                </tr>
            <?php endforeach; ?>
        </table>

        <form action="#" method="POST">
            <label for="dropdown_mittente">Mittente:</label>
            <select name="id_mittente" id="dropdown_mittente">
                <?php foreach ($conti as $conto): ?>
                    <option value="<?= $conto['id'] ?>">
                        <?= $conto['nome_utente'] ?>
                    </option>
                <?php endforeach; ?>
            </select>
            <br>

            <label for="dropdown_destinatario">Destinatario:</label>
            <select name="id_destinatario" id="dropdown_destinatario">
                <?php foreach ($conti as $conto): ?>
                    <option value="<?= $conto['id'] ?>">
                        <?= $conto['nome_utente'] ?>
                    </option>
                <?php endforeach; ?>
            </select>
            <br>

            <label for="importo">Importo:</label>
            <input type="number" name="importo">
            <br>

            <button type="submit">Trasferisci</button>
        </form>

    </body>
</html>