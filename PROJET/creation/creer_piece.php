<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création de personnage</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création pièce</h2>
        <select name="chateau">
            <?php
                include("../connexion.inc.php");
                $res = $cnx->query("
                    SELECT id_joueur
                    FROM joueur
                    WHERE login='".$_SESSION['pseudo']."'");
                $log = $res->fetchAll();

                $res = $cnx->query("
                    SELECT id_chateau, nom_chateau
                    FROM chateau
                    WHERE id_createur=".$log[0][0]);

                echo "<option value=''> -- Choisissez votre château --</option>";
                foreach ($res as $ligne) {
                    echo "<option value='".$ligne['id_chateau']."'>".$ligne['nom_chateau']."</option>";
                }

                
            ?>  
        </select>

        <input type="text" name="nom_piece" placeholder='Nom de la pièce'/>
        <textarea name="descriptif" rows="5" cols="30" maxlength="150" placeholder="Descriptif"></textarea>
        <input type="text" name="indices" placeholder='Indice de la pièce'/>
        Sortie <input type="checkbox" name="sortie" value="true">
        <input name="submit" type="submit" value="Créer"/>
    </form>
    </div>  
	<?php

		if (isset($_POST['submit'])){
            if (isset($_POST['sortie']) == "true")
                $table = "sortie";
            else
                $table = "piece";

            $resu = $cnx->exec("
                INSERT INTO ".$table."(nom_piece, descriptif, indices, id_chateau, id_createur) 
                VALUES ('".$_POST['nom_piece']."', '".$_POST['descriptif']."', '".$_POST['indices']."', ".$_POST['chateau'].", ".$log[0][0].")");

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
