<?php
	session_start();
	if (isset($_COOKIE['PHPSESSID']))
		if ($_COOKIE['PHPSESSID'] == session_id())
			return;

	session_destroy();
	setcookie("PHPSESSID","",time()-3600,"/");
	header('Refresh: 5; url=/PROJET/account/login.php');
	echo "<center>Erreur, Vous n'êtes pas authentifié,<br>redirection vers la page d'authentification dans 5 secondes</center>";
	exit;
?>