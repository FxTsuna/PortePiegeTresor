<?php 
	session_start();
	include("verif.php");

	if (!isset($_POST['chateau']))
			header("Location: stats.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Stats perso: <?php echo $_POST['nom_perso'] ?></title>
	<link rel="stylesheet" type="text/css" href="../CSS/stats.css">
</head>

<body>
	<h1>Statistiques du château <?php echo $_POST['chateau'] ?></h1>
	
	<form action="" method="post">
	<?php 
		include("../connexion.inc.php");

		echo '<input type="checkbox" name="chateau" value="'.$_POST["nom_chateau"].'" checked style="display:none;"/>';

		$res = $cnx->query("
				SELECT id_chateau
				FROM chateau
				WHERE nom_chateau='".$_POST['chateau']."'");
		$tmp = $res->fetchAll();
		$id_chateau = $tmp[0][0]; 

		$res = $cnx->query("
			SELECT nom_perso, date_explo
			FROM explorer
			JOIN personnage
			ON id_chateau=".$id_chateau."
			AND personnage.id_perso=explorer.id_chateau
			ORDER BY date_explo");
		
		echo '
		<table class="stats">
			<thead>
				<th class="stats">Date d\'exploration</th><th class="stats">Nom du joueur</th>
			</thead>
			<tbody>';

		foreach($res as $ligne){
			echo "
				<tr>
					<td class='stats'>".$ligne['date_explo']."</td>
					<td class='stats'>".$ligne['nom_perso']."</td>
				</tr>";
		}

		echo "</tbody></table>";

		$res->closeCursor();
	?>
	</form>
	</tbody>
	</tbody>
	</table>
	<button onclick="window.location.href = '../account/logout.php';" class="right top">Déconnexion</button>
	<button onclick="window.location.href = 'stats.php';" class="left top">Retour à l'onglet des stats</button>
</body>
</html>
