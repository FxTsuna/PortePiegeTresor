<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création de déverouillage</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création de déverouillage</h2>
        <select name="id_clef">
            <?php
                include("../connexion.inc.php");

                $res = $cnx->query("
                    SELECT id_clef, nom_objet
                    FROM clef
                    JOIN joueur
                    ON login='".$_SESSION['pseudo']."'
                    AND id_createur=id_joueur
                    ");

                foreach ($res as $ligne)
                    echo "<option value='".$ligne['id_clef']."'>".$ligne['nom_objet']."</option>";
            ?>
        </select>
        <select name="id_piece">
            <?php
                $res = $cnx->query("
                    SELECT id_piece, nom_piece
                    FROM piece
                    JOIN joueur
                    ON login='".$_SESSION['pseudo']."'
                    AND id_createur=id_joueur
                    ");

                foreach ($res as $ligne)
                    echo "<option value='".$ligne['id_piece']."'>".$ligne['nom_piece']."</option>";
            ?>
        </select>
        <input name="submit" type="submit" value="Créer"/>
    </form>
    </div>  
	<?php
		if (isset($_POST['submit'])){
            $res = $cnx->query("
                SELECT id_joueur
                FROM joueur
                WHERE login='".$_SESSION['pseudo']."'");
                $log = $res->fetchAll();

            $resu = $cnx->exec("
                INSERT INTO deverrouiller(id_clef, id_piece) 
                VALUES (".$_POST['id_clef'].", ".$_POST['id_piece'].")");

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
