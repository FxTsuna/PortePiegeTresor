<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Connexion</title>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css">
</head>

<body>
<?php 
	if (isset($_COOKIE['login']))
		$login = $_COOKIE['login'];
	else
		$login = '';

	if (isset($_COOKIE['mdp']))
		$mdp = $_COOKIE['mdp'];
	else
		$mdp = '';
?>
<div id='container'>
	<h1>Connexion</h1>
	<form action="login.php" method="post">
		<input type="text" name="pseudo" value="<?php echo $login ?>" autocomplete="off" placeholder="Nom d'utilisateur"/>
		<input type="password" name="mdp" value="<?php echo $mdp ?>" placeholder="Mot de passe"/>
		<input type="checkbox" name="memo_mdp" value="true" />
		Se souvenir<input type="submit" name="submit" value="Connexion" />
	</form>
</div>
<button onclick="window.location.href = 'create_account.php';" class="right down">S'inscrire</button>
</body>
</html>
