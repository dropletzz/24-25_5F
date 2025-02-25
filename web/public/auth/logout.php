<?php
    session_start(); # da fare ogni volta che usimo le sessioni
    session_destroy(); # elimina la sessione corrente
    header('Location: index.php');
?>