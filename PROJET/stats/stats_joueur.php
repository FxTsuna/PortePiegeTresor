<?php 
	session_start();
	include("verif.php");

	if (!isset($_POST['joueur']))
			header("Location: stats.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Stats du joueur: <?php echo $_POST['joueur'] ?></title>
	<link rel="stylesheet" type="text/css" href="../CSS/stats.css">
</head>

<body>
	<h1>Statistiques du joueur: <?php echo $_POST['joueur'] ?></h1>
	<?php 
		$src_p = '';
		$src_c = '';
	?>
	<form action="" method="post">
		<?php
			echo '<input type="radio" name="joueur" value="'.$_POST["joueur"].'" checked style="display:none;"/>';
			echo '<input type="text" name="nom_perso" placeholder="Personnage" value="'.$_POST["nom_perso"].'"/>';
			echo '<input type="text" name="chateau" placeholder="Chateau" value="'.$_POST['chateau'].'"/>';
		?>
		<input type="submit" name="submit" class="submit" value="Rechercher" style="display:none"/>
	</form>
	<?php
		include("../connexion.inc.php");
		if (isset($_POST['submit'])){
			if (isset($_POST['submit']))
				$src_p = $_POST["nom_perso"];

			if (isset($_POST['submit']))
				$src_c = $_POST["chateau"];
		}


		$res = $cnx->query("
        SELECT id_joueur
        FROM joueur
        WHERE login='".$_POST['joueur']."'");
	    $tmp = $res->fetchAll();
	    $log = $tmp[0][0];

		// TABLEAU PERSONNAGES
		$res_p = $cnx->query("
			SELECT nom_perso
    		FROM personnage
    		WHERE nom_perso LIKE '%".$src_p."%'
    		AND id_createur=".$log."
   			ORDER BY nom_perso
		");

		echo "<table class='stats'><thead><th class='stats'>Personnages</th></thead><tbody><form action='stats_perso.php' method='post'>";
		foreach ($res_p as $ligne) {
			echo "<tr><td class='stats'><input type='submit' class='stat' name='nom_perso' value='".$ligne['nom_perso']."'/></td></tr>";
		}
		echo "</form></tbody></table>";


		// TABLEAU CHATEAUX
		$res_c = $cnx->query("
			SELECT nom_chateau
    		FROM chateau
    		WHERE nom_chateau LIKE '%".$src_c."%'
    		AND id_createur=".$log."
   			ORDER BY nom_chateau
		");
		echo "<table class='stats'><thead><th class='stats'>Châteaux</th></thead><tbody><form action='stats_chateau.php' method='post'>";
		foreach ($res_c as $ligne) {
			echo "<tr><td class='stats'><input type='submit' class='stat' name='chateau' value='".$ligne['nom_chateau']."'/></td></tr>";
		}
		echo "</form></tbody></table>";


		$res->closeCursor();
	?>
	</form>

	<button onclick="window.location.href = '../account/logout.php';" class="right top">Déconnexion</button>
	<button onclick="window.location.href = 'stats.php';" class="left top">Retour à l'onglet des stats</button>
</body>
</html>
