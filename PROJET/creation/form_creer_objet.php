<?php 
    session_start();
    include("../session/verif.php");
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Création d'objet</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>
<body>
    <div id="container">
    <form action="redir_crea_obj.php" method="get" name="select_chateau">
        <h2>Création d'objet</h2>
        <select name='chateau' onchange="window.location.href=this.value">
            <?php
                include("../connexion.inc.php");
                $res = $cnx->query("
                    SELECT id_joueur
                    FROM joueur
                    WHERE login='".$_SESSION['pseudo']."'");
                $log = $res->fetchAll();

                if (isset($_GET['chateau'])){
                    $res = $cnx->query("
                    SELECT nom_chateau
                    FROM chateau
                    WHERE id_createur='".$log[0][0]."'
                    AND id_chateau=".$_GET['chateau']);
                    $ch = $res->fetchAll();

                    if (empty($ch)){
                        header('Refresh: 3; url='.$_SERVER['PHP_SELF']);
                        echo "<h1><font color='red'>Erreur, le chateau sélectionné n'est pas valide. Retour à la page précédente dans 3 secondes</font></h1>";
                        exit;
                    }
                    echo "<option value='".$_GET['chateau']."'>".$ch[0][0]."</option>";
                }

                echo "<option value='".$_SERVER['PHP_SELF']."'>-- Choisissez votre château --</option>";
                
                $res = $cnx->query("
                    SELECT id_chateau, nom_chateau
                    FROM chateau
                    WHERE id_createur=".$log[0][0]);

                foreach ($res as $ligne) {
                    if ($ligne['id_chateau'] != $_GET['chateau'])
                        echo "<option value='".$_SERVER['PHP_SELF']."?chateau=".$ligne['id_chateau']."'>".$ligne['nom_chateau']."</option>";
                }
                echo "</select>";


                echo "<select name='piece'><option value=''> -- Choisissez votre pièce --</option>";
                if (isset($_GET['chateau']) && $_GET['chateau'] != ''){
                    $res = $cnx->query("
                        SELECT id_piece, nom_piece
                        FROM piece
                        WHERE id_chateau=".$_GET['chateau']);
                    foreach ($res as $ligne) {
                      echo "<option value='".$ligne['id_piece']."'>".$ligne['nom_piece']."</option>";
                    }
                }
                echo "</select>";


            ?>  
            <select name="type_objet">
                <option value="">-- Choisissez votre type d'objet --</option>
                <option value="objet">Objet basique</option>
                <option value="clef">Clef</option>
                <option value="potion">Potion</option>
                <option value="piege">Piège</option>
            </select>

        <input name="submit" type="submit" value="Créer"/>
    </form> 
    </div>  
	<button onclick="window.location.href = '../account/logout.php';" class="right top">Déconnexion</button>
</body>
</html>
