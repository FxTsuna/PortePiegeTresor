<?php
	include('form_create_account.html');
	include('../connexion.inc.php');
	
	if (isset($_POST['submit'])){
		
		// Test si la session correspond à un utilisateur de la base
		if (isset($_POST['pseudo']) && isset($_POST['mdp']) && isset($_POST['conf_mdp'])){
			$res = $cnx->exec("INSERT INTO joueur(login, mdp) VALUES ('".$_POST['pseudo']."', '".md5($_POST['mdp'])."')");
			
			if ($res == 0){
				if ($_POST['mdp'] == $_POST['conf_mdp'])
					echo "<p><font color='white'>Erreur, cet identifiant est déjà pris</font></p>";
				else
					echo "<p><font color='white'>Erreur lors de la confirmation du mot de passe</font></p>";
			}
			else
				header("Location: login.php");
		}
	}
?>
