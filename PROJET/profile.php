<?php 
	session_start();
	include("session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Profil de <?php echo $_SESSION['pseudo'] ?></title>
	<link rel="stylesheet" type="text/css" href="CSS/style.css">
</head>

<body>
	<h1>Profil de <?php echo $_SESSION['pseudo'] ?></h1>


	<div><button onclick="window.location.href = 'stats/stats.php';">stats</button></div>
	<div><button onclick="window.location.href = 'creation/creation.php';">créer objets</button></div>
	<button onclick="window.location.href = 'account/logout.php';" class="down right">Déconnexion</button>

</body>
</html>
