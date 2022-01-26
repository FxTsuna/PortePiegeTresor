<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création de piège</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création de piège</h2>
        <input type="text" name="nom_piege" placeholder="Nom du piege" maxlength="20"/>
        <select name="classe_piege">
            <?php
                include("../connexion.inc.php");
                $res = $cnx->query("
                    SELECT id_classe_piege, nom_classe_piege
                    FROM classe_piege
                    JOIN joueur
                    ON login='".$_SESSION['pseudo']."' 
                    AND id_createur=id_joueur");

                foreach ($res as $ligne)
                    echo "<option value='".$ligne['id_classe_piege']."'>".$ligne['nom_classe_piege']."</option>";
            ?>
        </select>
        <input type="number" min="0" name="degats" placeholder="Dégâts"/>
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
                INSERT INTO piege(nom_piege, id_piece, id_createur, id_classe_piege, degats) 
                VALUES ('".$_POST['nom_piege']."', ".$_SESSION['piece'].", ".$log[0][0].", ".$_POST['classe_piege'].", ".$_POST['degats'].")");

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
