<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création de potion</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création de potion</h2>
        <input type="text" name="nom_potion" placeholder="Nom de la potion" maxlength="20"/>
        <input type="number" min="1" name="vie_rendue" placeholder='Vie rendue'/>
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
                INSERT INTO potion(nom_objet, id_piece, id_createur, vie_rendue) 
                VALUES ('".$_POST['nom_potion']."', ".$_SESSION['piece'].", ".$log[0][0].", ".$_POST['vie_rendue'].")");

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
