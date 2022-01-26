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
        <h2>Création de personnage</h2>
       <input type="text" name="nom" maxlength="20" placeholder='Personnage'/>
       <input type="number" min="1" name="vitalite_max" placeholder='Vitalité max'/>
        <select name="classe">
            <?php
                include("../connexion.inc.php");

                $res = $cnx->query("
                    SELECT id_joueur
                    FROM joueur
                    WHERE login='".$_SESSION['pseudo']."'");
                $log = $res->fetchAll();

                $res = $cnx->query("
                    SELECT id_classe, nom_classe
                    FROM classe
                    WHERE id_createur=".$log[0][0]);

                echo "<option value=''> -- Choisissez votre classe --</option>";
                foreach ($res as $ligne) {
                    echo "<option value='".$ligne['id_classe']."'>".$ligne['nom_classe']."</option>";
                }

                $res->closeCursor();
            ?>  
        </select>
        
        <input name="submit" type="submit" value="Valider"/>
    </form>    
	<?php

		if (isset($_POST['submit'])){
            $resu = $cnx->exec("
                INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) 
                VALUES ('".$_POST['nom']."', ".$_POST['vitalite_max'].", ".$_POST['vitalite_max'].", ".$_POST['classe'].", ".$log[0][0].")");

            if ($resu == 1)
                echo "<h1><font color='white'>Insertion réussie</font></h1>";
            else{
                echo "<h1><font color='red'>Erreur veuillez choisir une classe</font></h1>";
            }

        }

		
	?>
    </div>
    <button onclick="window.location.href = 'creation.php';" class="left down">Retour à l'onglet création</button>
    <button onclick="window.location.href = '../account/logout.php';" class="right down">Déconnexion</button>
</body>
</html>
