<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Création de réduction</title>
    <link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
    <div id="container">
    <form action="" method="post" >
        <h2>Création de réduction</h2>
        <?php
            include("../connexion.inc.php");
            $res = $cnx->query("
                SELECT id_joueur
                FROM joueur
                WHERE login='".$_SESSION['pseudo']."'");
            $log = $res->fetchAll();

            $res = $cnx->query("
                SELECT id_piece, nom_piece
                FROM piece
                WHERE id_createur=".$log[0][0]);


            echo "<select name='piece1'>";
            echo "<option value=''>-- Choisissez votre pièce --</option>";
            foreach ($res as $ligne) {
                echo "<option value='".$ligne['id_piece']."'>".$ligne['nom_piece']."</option>";
            }
            echo "</select>";

            echo "⇑ vers ⇓<input type='checkbox' name='1to2' value='true'/>";
            echo "<input type='checkbox' name='2to1' value='true'/>⇓ vers ⇑";

            $res = $cnx->query("
                SELECT id_piece, nom_piece
                FROM piece
                WHERE id_createur=".$log[0][0]);

            echo "<select name='piece2'>";
            echo "<option value=''>-- Choisissez votre pièce --</option>";
            foreach ($res as $ligne) {
                echo "<option value='".$ligne['id_piece']."'>".$ligne['nom_piece']."</option>";
            }
            echo "</select>";
        ?>     
        <input name="submit" type="submit" value="Créer"/>  
    </form>
    </div>   
    <?php
        if (isset($_POST['submit'])){
            if (isset($_POST['1to2']) == "true"){
                $resu = $cnx->exec("
                    INSERT INTO mener_sur(id_piece_depart, id_piece_arrivee) 
                    VALUES (".$_POST['piece1'].", ".$_POST['piece2'].")");

                if ($resu == 1){
                    echo "<h1><font color='white'>Insertion réussie ⇑ vers ⇓</font></h1>";
                } else{
                    echo "<h1><font color='red'>Erreur lors de l'entrée de vos données ⇑ vers ⇓</font></h1>";
                }
            }

            if (isset($_POST['2to1']) == "true"){
                $resu = $cnx->exec("
                    INSERT INTO mener_sur(id_piece_depart, id_piece_arrivee) 
                    VALUES (".$_POST['piece2'].", ".$_POST['piece1'].")");

                if ($resu == 1){
                    echo "<h1><font color='white'>Insertion réussie ⇓ vers ⇑</font></h1>";
                } else{
                    echo "<h1><font color='red'>Erreur lors de l'entrée de vos données ⇓ vers ⇑</font></h1>";
                }
            }
        }
        $res->closeCursor();
    ?>
    <button onclick="window.location.href = 'creation.php';" class="left down">Retour à l'onglet création</button>
    <button onclick="window.location.href = '../account/logout.php';" class="right down">Déconnexion</button>
</body>
</html>
