<?php

/*
 * création d'objet PDO de la connexion qui sera représenté par la variable $cnx
 */
$user =  'padawan';// A COMPLETER
$pass =  '7ziyvau6pM';// A COMPLETER
try {
    $cnx = new PDO('pgsql:host=localhost;dbname=zwendodb', $user, $pass);  // A COMPLETER  
}
catch (PDOException $e) {
    echo "ERREUR : La connexion a échouée";
    echo "Error: " . $e;

 /* Utiliser l'instruction suivante pour afficher le détail de erreur sur la
 * page html. Attention c'est utile pour débugger mais cela affiche des
 * informations potentiellement confidentielles donc éviter de le faire pour un
 * site en production.*/
//    echo "Error: " . $e;

}

?>

