<?php session_start() ?>
<?php
	include('form_login.php');
	include('../connexion.inc.php');
	$req = "SELECT * FROM joueur WHERE login=? AND mdp=?";

	if (isset($_POST['submit'])){
		
		//echo "<p>".var_dump(isset($_POST['pseudo']))."</p>";
		// Test si la session correspond à un utilisateur de la base
		if (isset($_POST['pseudo']) && isset($_POST['mdp'])){
			$res = $cnx->prepare($req);
			$res->execute(array($_POST['pseudo'], md5($_POST['mdp'])));
			$resultat = $res-> fetchAll();
			$res->closeCursor();
			
			if (!empty($resultat)){
				$_SESSION["pseudo"] = $_POST["pseudo"];
				if (isset($_POST['memo_mdp']) && $_POST['memo_mdp'] == "true"){
						header('Location: save_login.php');
						return;
				}
				
				header('Location: ../profile.php');
				return;
			}	
		}
		echo "<p><font color='red'>Erreur lors de la saisie de votre identifiant ou de votre mot de passe</font></p>";
	}
	session_destroy();
	setcookie("PHPSESSID","",time()-3600,"/");
?>
