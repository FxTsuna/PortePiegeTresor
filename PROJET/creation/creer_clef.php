<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création de clef</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création de clef</h2>
        <input type="text" name="nom_clef" placeholder="Nom de la clef" maxlength="20"/>
        <input type="number" name="id_clef" placeholder="Code clef"/>
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
                INSERT INTO clef(nom_objet, id_piece, id_createur, id_clef) 
                VALUES ('".$_POST['nom_clef']."', ".$_SESSION['piece'].", ".$log[0][0].", ".$_POST['id_clef'].")");

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
