<?php 
	session_start();
	include("verif.php");

	if (!isset($_POST['nom_perso']))
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
	<h1>Statistiques de <?php echo $_POST['nom_perso'] ?></h1>
	
	<form action="" method="post">
	<?php 
		include("../connexion.inc.php");

		echo '<input type="checkbox" name="nom_perso" value="'.$_POST["nom_perso"].'" checked style="display:none;"/>';

		$res = $cnx->query("
				SELECT id_perso
				FROM personnage
				WHERE nom_perso='".$_POST['nom_perso']."'");
		$tmp = $res->fetchAll();
		$id_perso = $tmp[0][0]; 

		$res = $cnx->query("
			SELECT explorer.id_chateau, nom_chateau, date_explo
			FROM explorer
			JOIN chateau
			ON id_perso=".$id_perso."
			AND chateau.id_chateau = explorer.id_chateau
			ORDER BY date_explo");
		$table = $res->fetchAll();
		
		$req_reu = "
			SELECT date_trouv
			FROM sortie
			JOIN se_trouver
			ON se_trouver.id_piece = sortie.id_piece
			AND id_perso=".$id_perso;
		
		$req_nb_pieces = "
			SELECT count(*)
			FROM se_trouver
			WHERE id_perso=".$id_perso;		

		$def_interval = " AND date_trouv BETWEEN ? AND ?";
		$dern_interval = " AND date_trouv >= ?";
		

		// On détermine quels châteaux ont été terminés
		$victoires = 0;
		for($i=0; $i<count($table); $i++){
			if ($i+1 < count($table)){
				$reussite = $cnx->prepare($req_reu.$def_interval);
				$nb_pieces = $cnx->prepare($req_nb_pieces.$def_interval);
				$array = array($table[$i]['date_explo'], $table[$i+1]['date_explo']);
			
			}else{
				$reussite = $cnx->prepare($req_reu.$dern_interval);
				$nb_pieces = $cnx->prepare($req_nb_pieces.$dern_interval);
				$array = array($table[$i]['date_explo']);
			}
			

			$reussite->execute($array);
			$tmp_r = $reussite->fetchAll();

			if(empty($tmp_r)){
				$table[$i]["reussite"] = false;

			}else{
				$table[$i]["reussite"] = true;
				$victoires++;
			}

			$nb_pieces->execute($array);
			$tmp_nb = $nb_pieces->fetchAll();

			$table[$i]["nb_pieces"] = $tmp_nb[0][0];
		}

		echo "<p>Châteaux explorés: ".count($table)."</p><p><font color='blue'>Châteaux réussis: ".$victoires."</font></p><p><font color='red'>Châteaux échoués: ".(count($table) - $victoires)."</font></p>";

		echo '<table class="stats">
		<thead><th class="stats">Date d\'exploration</th><th class="stats">Nom du château</th><th class="stats">Etat</th><th class="stats">Nombre de pièces parcourues</th><th class="stats">Sélection</th></thead>
		<tbody>';
		// affichage
		for ($i=0; $i<count($table); $i++){
			if ($table[$i]['reussite'])
				$txt = "<font color='blue'>Réussi</font>";
			else if ($i+1 < count($table))
				$txt = "<font color='red'>Echoué</font>";
			else
				$txt = "<font color='gray'>En cours</font>";

			echo "
				<tr>
					<td class='stats'>".$table[$i]['date_explo']."</td>
					<td class='stats'>".$table[$i]['nom_chateau']."</td>
					<td class='stats'>".$txt."</td>
					<td class='stats'>".$table[$i]['nb_pieces']."</td>
					<td class='stats'><input type='radio' name='chateau' value=".$i." /></td>

				</tr>";
		}
		echo "</tbody></table>";
		
		$res->closeCursor();

	?>
	<input type="submit" name="submit"  value="Afficher stats détaillées"/>
	</form>

	<button onclick="window.location.href = '../account/logout.php';" class="right top">Déconnexion</button>
	<button onclick="window.location.href = 'stats.php';" class="left top">Retour à l'onglet des stats</button>

	<?php
		if (!isset($_POST['chateau']))
			return;

		echo '<table class="stats">
		<thead><th class="stats">Date d\'exploration</th><th class="stats">Pièce</th></thead>
		<tbody>';

		$id_ch = intval($_POST['chateau']);
		if (($id_ch + 1) == count($table))
			$date_inter = " > '".$table[$id_ch]['date_explo']."'";
		else
			$date_inter = " BETWEEN '".$table[$id_ch]['date_explo']."' AND '".$table[$id_ch + 1]['date_explo']."'";

		
		$res = $cnx->query("
			SELECT date_trouv, nom_piece
			FROM se_trouver
			JOIN piece
			ON id_perso=".$id_perso."
			AND se_trouver.id_piece = piece.id_piece
			AND date_trouv".$date_inter."
			ORDER BY date_trouv
			");

		foreach ($res as $ligne) {
			echo "<tr><td class='stats'>".$ligne['date_trouv']."</td><td class='stats'>".$ligne['nom_piece']."</td></tr>";
		}
		echo "</tbody></table>";
	?>
</body>
</html>
