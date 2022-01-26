<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création d'objet basique</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création d'objet basique</h2>
        <input type="text" name="nom_objet" placeholder="Nom de l'objet" maxlength="20"/>
        <input name="submit" type="submit" value="Créer"/>
    </form>
    </div>  
	<?php
		if (isset($_POST['submit'])){
            include("../connexion.inc.php");
            $res = $cnx->query("
                SELECT id_joueur
                FROM joueur
                WHERE login='".$_SESSION['pseudo']."'");
                $log = $res->fetchAll();

            $resu = $cnx->exec("
                INSERT INTO objet(nom_objet, id_piece, id_createur) 
                VALUES ('".$_POST['nom_objet']."', ".$_SESSION['piece'].", ".$log[0][0].")");

            if ($resu == 1){
                echo "<h1><font color='white'>Insertion réussie</font></h1>";
            } else{
                echo "<h1><font color='red'>Erreur lors de l'entrée de vos données</font></h1>";
            }
        }
        $res->closeCursor();
	?>
	<button onclick="window.location.href = 'creation.php';" class="left down">Retour à l'onglet création</button>
    <button onclick="window.location.href = '../account/logout.php';" class="right down">Déconnexion</button>
</body>
</html>
