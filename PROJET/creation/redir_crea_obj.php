<?php session_start() ?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title></title>
</head>
<body>
<?php
	include("../session/verif.php");


	function form_error(){
		header('Refresh: 3; url=form_creer_objet.php');
        echo "<center><font color='red'>Erreur, les données sélectionnées sont erronées ou vous ne possédez pas les droits nécessaire</font></center>";
        exit;
	}

	if (!isset($_GET['submit']))
		form_error();

	include("../connexion.inc.php");

	$res = $cnx->query("
        SELECT id_joueur
        FROM joueur
        WHERE login='".$_SESSION['pseudo']."'");
    $tmp = $res->fetchAll();
    $log = $tmp[0][0];

	$res = $cnx->query("
		SELECT id_chateau
		FROM chateau
		WHERE id_chateau =".$_GET['chateau']."
		AND id_createur=".$log);
	$tmp = $res->fetchAll();
	if (empty($tmp))
		form_error();
	else
		$chateau = $tmp[0][0];

	$res = $cnx->query("
        SELECT id_piece
        FROM piece
        WHERE id_chateau=".$chateau);
	$tmp = $res->fetchAll();
	if (empty($tmp))
		form_error();
	else
		$piece = $tmp[0][0];

	$types = array ("objet", "clef", "piege", "potion");
	if (!in_array($_GET['type_objet'], $types))
		form_error();

	$_SESSION['piece'] = $_GET['piece'];

	if ($_GET['type_objet'] == "objet")
		header("Location: creer_objet_basique.php");
	elseif ($_GET['type_objet'] == "clef")
		header("Location: creer_clef.php");
	elseif ($_GET['type_objet'] == "piege")
		header("Location: creer_piege.php");
	else
		header("Location: creer_potion.php");
?>
</body>
</html>