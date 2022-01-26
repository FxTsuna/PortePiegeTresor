<?php session_start() ?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Satistiques</title>
	<link rel="stylesheet" type="text/css" href="../CSS/stats.css">
</head>

<body>
	<?php include("verif.php") ?>
	<h1>Statistiques</h1>
	<?php 
		$src_p = '';
		$src_c = '';
		$src_j = '';
	?>
	<button onclick="window.location.href = '../account/logout.php';" class="right top">Déconnexion</button>
	<button onclick="window.location.href = '../profile.php';"  class='left top'>Retour</button>
	<form action="" method="post">
		<?php
			echo '<input type="text" name="nom_perso" placeholder="Personnage" value="'.$_POST["nom_perso"].'"/>';
			echo '<input type="text" name="chateau" placeholder="Chateau" value="'.$_POST['chateau'].'"/>';
			echo '<input type="text" name="joueur" placeholder="Joueur" value="'.$_POST['joueur'].'"/>';
		?>
		<input type="submit" class='submit' name="submit" value="Rechercher" style="display:none"/>
	</form>
	<?php
		include("../connexion.inc.php");
		if (isset($_POST['submit'])){
			if (isset($_POST['submit']))
				$src_p = $_POST["nom_perso"];

			if (isset($_POST['submit']))
				$src_c = $_POST["chateau"];

			if (isset($_POST['submit']))
				$src_j = $_POST["joueur"];
		}

		// TABLEAU PERSONNAGES
		$res_p = $cnx->query("
			SELECT nom_perso
    		FROM personnage
    		WHERE nom_perso LIKE '%".$src_p."%'
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
   			ORDER BY nom_chateau
		");
		echo "<table class='stats'><thead><th class='stats'>Châteaux</th></thead><tbody><form action='stats_chateau.php' method='post'>";
		foreach ($res_c as $ligne) {
			echo "<tr><td class='stats'><input type='submit' class='stat' name='chateau' value='".$ligne['nom_chateau']."'/></td></tr>";
		}
		echo "</form></tbody></table>";


		// TABLEAU JOUEURS
		$res_j = $cnx->query("
			SELECT login
    		FROM joueur
    		WHERE login LIKE '%".$src_j."%'
   			ORDER BY login
		");
		echo "<table class='stats'><thead><th class='stats'>Joueurs</th></thead><tbody><form action='stats_joueur.php' method='post'>";
		foreach ($res_j as $ligne) {
			echo "<tr><td class='stats'><input type='submit' class='stat' name='joueur' value='".$ligne['login']."'/></td></tr>";
		}
		echo "</form></tbody></table>";


		$res->closeCursor();
	?>

	
</body>
</html>
