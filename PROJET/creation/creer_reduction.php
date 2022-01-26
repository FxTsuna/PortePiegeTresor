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

                
            ?>  
        </select> 
        <input type="number" min="1" name="reduction" placeholder='Réduction'/>
        <select name="classe_piege">
            <?php
                $res = $cnx->query("
                    SELECT id_classe_piege, nom_classe_piege
                    FROM classe_piege
                    WHERE id_createur=".$log[0][0]);

                echo "<option value=''> -- Choisissez votre classe de piège --</option>";
                foreach ($res as $ligne) {
                    echo "<option value='".$ligne['id_classe_piege']."'>".$ligne['nom_classe_piege']."</option>";
                }  
            ?>  
        </select>   
        <input name="submit" type="submit" value="Créer"/>  
    </form>
    </div>   
    <?php
        
        if (isset($_POST['submit'])){
            $resu = $cnx->exec("
                INSERT INTO reduire(id_classe, id_classe_piege, reduction) 
                VALUES (".$_POST['classe'].", ".$_POST['classe_piege'].", ".$_POST['reduction'].")");
            
            if ($resu == 1){
                echo "<h1><font color='white'>Insertion réussie</font></h1>";
                // if ($_POST['redirect'] == "true")

            } else{
                echo "<h1><font color='red'>Erreur lors de l'insertion, réduction déjà existante</font></h1>";
            }
        }

        $res->closeCursor();
    ?>
    <button onclick="window.location.href = 'creation.php';" class="left down">Retour à l'onglet création</button>
    <button onclick="window.location.href = '../account/logout.php';" class="right down">Déconnexion</button>
</body>
</html>
