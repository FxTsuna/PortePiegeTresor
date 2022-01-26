<?php
	session_start();
	if (isset($_SESSION["login"]) && isset($_SESSION["mdp"])){
		setCookie("login", $_SESSION["login"], time() + 3600*24);
		setCookie("mdp", md5($_SESSION["mdp"]), time() + 3600*24);
	}
	header('Location: ../profile.php');
?>