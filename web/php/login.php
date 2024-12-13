<!DOCTYPE html>

<html>

<head>
    <title>Login</title>
    <link href="style.css" rel="stylesheet" />
</head>

<body>

    <?php 
		$frutta = array(
			0 => "Mele",
			1 => "Pere",
			2 => "Banane",
		);
		
		echo "<ol>";
		foreach ($frutta as $f) {
			echo "<li>{$f}</li>";
		}
		echo "</ol>";
    ?>
	
    <div class="contenitore">
        <form action="#">
            <label for="form-email">Inserisci email</label><br/>
            <input id="form-email" type="text"><br/>
            <label for="form-password">Inserisci password</label><br/>
            <input id="form-password" type="password"><br/>
            <button id="form-submit">Invia</button>
        </form>
    </div>
</body>

</html>