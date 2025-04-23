
<?php

// Connessione al database
$servername = $_ENV['DB_HOST'] ?? 'localhost';
$username = 'root';
$password = '';

// provo a connettermi al db
$conn = new mysqli($servername, $username, $password, "traffico");

$archi = $conn->query('SELECT id, toponimo FROM Arco');

// Recupero parametri GET
$data = isset($_GET['data']) ? $_GET['data'] : '';
$id_arco = isset($_GET['id_arco']) ? $_GET['id_arco'] : '';

// Verifica se è stata passata una data
if ($data !== '') {
    // Query base
    $query = "
        SELECT m.data, i.nome AS nome_inquinante, m.id_stazione, m.id_inquinante, m.value, i.soglia_attenzione, i.soglia_allarme, s.nome AS nome_stazione, a.toponimo toponimo_arco
        FROM Misurazione m
        JOIN Inquinante i ON m.id_inquinante = i.id
        JOIN StazioneDiMisurazione s ON m.id_stazione = s.id
        JOIN Arco a ON s.id_arco = a.id
        WHERE DATE(m.data) = ?
    ";

    // Aggiungi filtro arco se specificato
    if ($id_arco !== '') {
        $query .= " AND a.id = ? ";
    }

    $query .= "ORDER BY i.nome, m.data, s.nome";

    // Prepara ed esegui
    $stmt = $conn->prepare($query);
    if ($id_arco !== '') {
        $stmt->bind_param("si", $data, $id_arco);
    } else {
        $stmt->bind_param("s", $data);
    }

    $stmt->execute();
    $result = $stmt->get_result();
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Livello inquinanti</title>
</head>
<body>
    <h2>Consulta livello inquinanti</h2>
    <form method="get">
        <label>Data:</label>
        <input type="date" name="data" required value="<?= htmlspecialchars($data) ?>">
        <label>Arco stradale:</label>
        <select name="id_arco" id="select-arco">
            <option value="">Tutti gli archi</option>
            <? while ($arco = $archi->fetch_assoc()): ?>
                <option value="<?= $arco['id'] ?>" <?= $id_arco === $arco['id'] ? 'selected' : '' ?>><?= $arco['toponimo'] ?></option>
            <? endwhile ?>
        </select>
        <button type="submit">Cerca</button>
    </form>
    <?php if ($data): ?>
        <h3>Risultati per <?= htmlspecialchars($data) ?>:</h3>
        <table border="1" cellpadding="5">
            <tr>
                <th>Arco stradale</th>
                <th>Stazione</th>
                <th>Inquinante</th>
                <th>Valore misurato</th>
                <th>Data misurazione</th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td><?= $row['toponimo_arco'] ?></td>
                    <td><?= $row['nome_stazione'] ?></td>
                    <td><?= $row['nome_inquinante'] ?></td>
                    <td><?= round($row['value'], 2) ?></td>
                    <td><?= $row['data'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    <?php endif; ?>

</body>
</html>