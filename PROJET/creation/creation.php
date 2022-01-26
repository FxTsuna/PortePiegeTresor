<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="../CSS/style.css">
	<title>Accueil création de personnage</title>
	<style type="text/css">
	</style>
</head>

<body>

	<div id="box">
		<h1>Outils de création</h1>
		<button class="creation" onclick="window.location.href = 'creer_perso.php';">Créer personnage</button>
	    <button class="creation" onclick="window.location.href = 'creer_chateau.php';">Créer château</button>
	    <button class="creation" onclick="window.location.href = 'creer_piece.php';">Créer pièce</button>
	    <button class="creation" onclick="window.location.href = 'creer_classe_piege.php';">Créer classe piège</button>
	    <button class="creation" onclick="window.location.href = 'creer_classe.php';">Créer classe</button>
	    <button class="creation" onclick="window.location.href = 'creer_mener_sur.php';">Créer mener sur</button>
	    <button class="creation" onclick="window.location.href = 'form_creer_objet.php';">Créer objet</button>
	    <button class="creation" onclick="window.location.href = 'creer_deverrouiller.php';">Créer un déverrouillage</button>
	    <button class="creation" onclick="window.location.href = 'creer_reduction.php';">Créer réduction de dégâts</button>
	</div>
	</div>
	<button onclick="window.location.href = '../profile.php';"  class='right down'>Retour</button>
</body>
</html>
