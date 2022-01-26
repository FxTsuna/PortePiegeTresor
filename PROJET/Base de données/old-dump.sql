--
-- Drop tables
--

DROP TABLE IF EXISTS se_trouver CASCADE;
DROP TABLE IF EXISTS reduire CASCADE;
DROP TABLE IF EXISTS deverrouiller CASCADE;
DROP TABLE IF EXISTS sortie CASCADE;
DROP TABLE IF EXISTS posseder CASCADE;
DROP TABLE IF EXISTS mener_sur CASCADE;
DROP TABLE IF EXISTS potion CASCADE;
DROP TABLE IF EXISTS clef CASCADE;
DROP TABLE IF EXISTS objet CASCADE;
DROP TABLE IF EXISTS piege CASCADE;
DROP TABLE IF EXISTS piece CASCADE;
DROP TABLE IF EXISTS chateau CASCADE;
DROP TABLE IF EXISTS personnage CASCADE;
DROP TABLE IF EXISTS classe CASCADE;
DROP TABLE IF EXISTS classe_piege CASCADE;
DROP TABLE IF EXISTS joueur CASCADE;
DROP TABLE IF EXISTS explorer;

--
-- Create table joueur
--
CREATE TABLE joueur (
	id_joueur SERIAL PRIMARY KEY,
	 login varchar(20) NOT NULL UNIQUE,
	 mdp varchar(32) NOT NULL
);


--
-- Create table chateau
--
CREATE TABLE chateau (
	id_chateau serial PRIMARY KEY,
	 nom_chateau varchar(20) NOT NULL UNIQUE,
	 id_createur int,
		CONSTRAINT chateau_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table piece
--
CREATE TABLE piece (
	id_piece serial PRIMARY KEY,
	 nom_piece varchar(20) NOT NULL,
	 descriptif varchar(150),
	 indices varchar(50) NOT NULL,
	 id_chateau int,
		CONSTRAINT piece_id_chateau_fkey FOREIGN KEY (id_chateau) REFERENCES chateau(id_chateau)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 id_createur int,
		CONSTRAINT piece_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table classe 
--
CREATE TABLE classe (
	id_classe serial PRIMARY KEY,
	 nom_classe varchar(20) NOT NULL,
	 id_createur int NOT NULL,
		CONSTRAINT classe_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table personnage
--
CREATE TABLE personnage (
	id_perso serial PRIMARY KEY,
	 nom_perso varchar(20) NOT NULL UNIQUE,
	 vitalite_max int NOT NULL,
		CONSTRAINT vitalite_positive CHECK (vitalite_max > 0),
	 vitalite int NOT NULL,
		 CONSTRAINT vitalite_interval CHECK (vitalite BETWEEN 0 AND vitalite_max),
	 id_classe int,
		CONSTRAINT personnage_id_classe_fkey FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 id_createur int,
		CONSTRAINT personnage_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);



--
-- Create table objet
--
CREATE TABLE objet (
	id_objet serial PRIMARY KEY,
	 nom_objet varchar(20) NOT NULL,
	 id_piece int,
		CONSTRAINT objet_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 id_createur int,
		CONSTRAINT objet_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table posseder
--
CREATE TABLE posseder (
	id_objet int,
		CONSTRAINT posseder_id_objet_fkey FOREIGN KEY (id_objet) REFERENCES objet(id_objet)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_possesseur int,
		CONSTRAINT posseder_id_perso_fkey FOREIGN KEY (id_possesseur) REFERENCES personnage(id_perso)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(id_objet, id_possesseur)
);



--
-- Create table explorer
--
CREATE TABLE explorer (
	id_perso int,
		CONSTRAINT explorer_id_perso_fkey FOREIGN KEY (id_perso) REFERENCES personnage(id_perso)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_chateau int,
		CONSTRAINT explorer_id_chateau_fkey FOREIGN KEY (id_chateau) REFERENCES chateau(id_chateau)
		ON DELETE CASCADE ON UPDATE CASCADE,
	date_explo timestamp NOT NULL,
	PRIMARY KEY(id_perso, id_chateau, date_explo)
);

--
-- Create table sortie
--
CREATE TABLE sortie (
	id_sortie serial UNIQUE
) INHERITS (piece);


--
-- Create table potion
--
CREATE TABLE potion (
	vie_rendue int NOT NULL,
		CONSTRAINT valeur_vie_rendue CHECK (vie_rendue > 0)
) INHERITS (objet);


--
-- Create table clef
--
CREATE TABLE clef (
	id_clef int NOT NULL UNIQUE
) INHERITS (objet);


--
-- Create table classe_piege
--
CREATE TABLE classe_piege (
	id_classe_piege serial PRIMARY KEY,
	 nom_classe_piege varchar(20) NOT NULL,
	 id_createur int,
		CONSTRAINT classe_piege_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table piege
--
CREATE TABLE piege (
	id_piege serial PRIMARY KEY,
	 nom_piege varchar(20) NOT NULL,
	 id_piece int,
		CONSTRAINT piege_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 id_classe_piege int,
		CONSTRAINT piege_id_classe_piege_fkey FOREIGN KEY (id_classe_piege) REFERENCES classe_piege(id_classe_piege)
		ON DELETE CASCADE ON UPDATE CASCADE,
	 degats int NOT NULL,
		CONSTRAINT valeur_degats CHECK (degats > 0),
	 id_createur int,
		CONSTRAINT piege_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES joueur(id_joueur)
		ON DELETE CASCADE ON UPDATE CASCADE
);


--
-- Create table setrouver
--
CREATE TABLE se_trouver (
	id_piece int,
		CONSTRAINT se_trouver_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_perso int,
		CONSTRAINT se_trouver_id_perso_fkey FOREIGN KEY (id_perso) REFERENCES personnage(id_perso)
		ON DELETE CASCADE ON UPDATE CASCADE,
	date_trouv timestamp NOT NULL,
	PRIMARY KEY (id_piece, id_perso, date_trouv)

);

--
-- Create table reduire
--
CREATE TABLE reduire (
	id_classe int,
		CONSTRAINT reduire_id_classe_fkey FOREIGN KEY (id_classe) REFERENCES classe(id_classe)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_classe_piege int,
		CONSTRAINT reduire_id_classe_piege FOREIGN KEY (id_classe_piege) REFERENCES classe_piege(id_classe_piege)
		ON DELETE CASCADE ON UPDATE CASCADE,
	reduction int NOT NULL,
		CONSTRAINT reduction_value CHECK (reduction > 0),
	PRIMARY KEY (id_classe, id_classe_piege)
);


--
-- Create table mener_sur
--
CREATE TABLE mener_sur (
	id_piece_depart int,
		CONSTRAINT mener_sur_id_piece_depart_fkey FOREIGN KEY (id_piece_depart) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_piece_arrivee int,
		CONSTRAINT mener_sur_id_piece_arrivee_fkey FOREIGN KEY (id_piece_arrivee) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (id_piece_depart, id_piece_arrivee),
	CONSTRAINT pieces_differentes CHECK (id_piece_depart <> id_piece_arrivee)
);


--
-- Create table deverouiller
--
CREATE TABLE deverrouiller (
	id_clef int,
		CONSTRAINT deverrouiller_id_clef FOREIGN KEY (id_clef) REFERENCES clef(id_clef)
		ON DELETE CASCADE ON UPDATE CASCADE,
	id_piece int,
		CONSTRAINT deverrouiller_id_piece FOREIGN KEY (id_piece) REFERENCES piece(id_piece)
		ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (id_clef, id_piece)
);


--
-- Data for Name: joueur
--
INSERT INTO joueur(login, mdp) VALUES ('lcreanto', '60d9de75012d87dad78d9fba9076d397'); -- lcreanto1
INSERT INTO joueur(login, mdp) VALUES ('fxu', '1a6327fe3522267c3ad5c9240bfdfe82'); -- fxu2
INSERT INTO joueur(login, mdp) VALUES ('upem', '5259ebb16afdf8a26cc92e78e96c02de'); -- upemL2
INSERT INTO joueur(login, mdp) VALUES ('tsu','tsunts');
INSERT INTO joueur(login, mdp) VALUES ('4head','pepega');
INSERT INTO joueur(login, mdp) VALUES ('higahashier','riyumi');
INSERT INTO joueur(login, mdp) VALUES ('ezriel','xanto');
INSERT INTO joueur(login, mdp) VALUES ('keredo','vivi');


--
-- Data for Name: chateau
--
INSERT INTO chateau(nom_chateau, id_createur) VALUES ('forteresse', 1);
INSERT INTO chateau(nom_chateau, id_createur) VALUES ('chateau', 1);
INSERT INTO chateau(nom_chateau, id_createur) VALUES ('bastille', 3);



--
-- Data for Name: piece
--
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('hall', 'la premiere piece du chateau', 'regardez sous le tapis', 1, 1);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('prison', 'l endroit ou est enferme le dragon', 'la trosieme cellule semble etrange', 1, 1);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('chambre', 'la chambre du roi', 'la lumiere est la clef', 2, 2);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('cuisines', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 3);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('zoo', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 8);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('cage', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 6);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('bibliothèque', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 6);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('cave', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 8);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('chambre secrète', 'on y prepare les meilleurs mets', 'coupez les gateaux', 3, 6);
INSERT INTO piece(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('salle gaming', 'on y prepare les meilleurs joueurs', 'aegn', 3, 8);



--
-- Data for Name: classe
--
INSERT INTO classe(nom_classe, id_createur) VALUES ('genie', 1);
INSERT INTO classe(nom_classe, id_createur) VALUES ('alchimiste', 1);
INSERT INTO classe(nom_classe, id_createur) VALUES ('genie', 2);
INSERT INTO classe(nom_classe, id_createur) VALUES ('mecanicien', 3);
INSERT INTO classe(nom_classe, id_createur) VALUES ('dompteur', 6);
INSERT INTO classe(nom_classe, id_createur) VALUES ('sorcier', 8);
INSERT INTO classe(nom_classe, id_createur) VALUES ('xelor', 3);
INSERT INTO classe(nom_classe, id_createur) VALUES ('yasuo', 8);


--
-- Data for Name: personnage
--
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('zwendo', 30, 25, 1, 1);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('fxtsuna', 24, 12, 3, 2);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('etudiant en L2', 10, 10, 3, 3);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('zbeub', 15, 10, 7, 4);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('neocrest', 20, 15, 8, 5);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('shade', 30, 30, 6, 6);
INSERT INTO personnage(nom_perso, vitalite_max, vitalite, id_classe, id_createur) VALUES ('helly', 50, 45, 5, 8);



--
-- Data for Name: objet 
--
INSERT INTO objet(nom_objet, id_piece, id_createur) VALUES ('morceau de verre', 1, 1);
INSERT INTO objet(nom_objet, id_piece, id_createur) VALUES ('oreiller', 3, 2);
INSERT INTO objet(nom_objet, id_piece, id_createur) VALUES ('fourchette', 4, 3);
INSERT INTO objet(nom_objet, id_piece, id_createur) VALUES ('casque gaming', 10, 7);


--
-- Data for Name: potion
--
INSERT INTO potion(nom_objet, id_piece, id_createur, vie_rendue) VALUES ('potion amelioree', 3, 2, 2);
INSERT INTO potion(nom_objet, id_piece, id_createur, vie_rendue) VALUES ('potion au choux', 4, 3, 3);
INSERT INTO potion(nom_objet, id_piece, id_createur, vie_rendue) VALUES ('potion de l esprit', 7, 6, 10);
INSERT INTO potion(nom_objet, id_piece, id_createur, vie_rendue) VALUES ('potion feed ', 10, 8, 5);



--
-- Data for Name: clef
--
INSERT INTO clef(nom_objet, id_piece, id_createur, id_clef) VALUES ('clef de la prison', 21, 1, -1);


--
-- Data for Name: classe_piege
--
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('enigme mortelle', 1);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('poison', 1);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('enigme mortelle', 2);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('piege mecanique', 3);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('monstre', 8);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('magique', 6);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('temporelle', 6);
INSERT INTO classe_piege(nom_classe_piege, id_createur) VALUES ('bronze trap', 3);

--
-- Data for Name: sortie
--
INSERT INTO sortie(nom_piece, descriptif, indices, id_chateau, id_createur) VALUES ('sortie', 'vous avez reussi', 'bravo', 1, 1);

--
-- Data for Name: piege
--
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('enigme du sphinx', 1, 1, 100, 1);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('gaz moutarde', 2, 2, 10, 1);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('enigme de toto', 3, 3, 2, 2);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('piege a ours', 3, 4, 15, 3);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('hydre', 5, 5, 30, 8);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('ours', 5, 6, 20, 8);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('explosion arcanique', 6, 7, 30, 6);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('néant distordu', 7, 8, 100, 6);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('salle du temps', 7, 9, 15, 6);
INSERT INTO piege(nom_piege, id_classe_piege, id_piece, degats, id_createur) VALUES ('salle du fer 4', 8, 10, 50, 3);


--
-- Data for Name: reduire
--
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (1, 1, 100);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (1, 2, 5);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (3, 2, 1);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (4, 4, 10);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (5, 5, 20);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (6, 6, 30);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (7, 7, 15);
INSERT INTO reduire(id_classe, id_classe_piege, reduction) VALUES (8, 8, 50);

--
-- Data for Name: explorer
--
INSERT INTO explorer(id_perso, id_chateau, date_explo) VALUES (1, 1, '2019-12-03 13:03:17');
INSERT INTO explorer(id_perso, id_chateau, date_explo) VALUES (1, 2, '2018-12-03 17:00:01');

--
-- Data for Name: se_trouver
--
INSERT INTO se_trouver(id_perso, id_piece, date_trouv) VALUES (1, 1, '2018-12-03 18:25:14');
INSERT INTO se_trouver(id_perso, id_piece, date_trouv) VALUES (1, 2, '2018-12-03 18:26:14');
INSERT INTO se_trouver(id_perso, id_piece, date_trouv) VALUES (1, 1, '2018-12-03 18:27:14');
INSERT INTO se_trouver(id_perso, id_piece, date_trouv) VALUES (1, 2, '2019-12-03 18:31:14');

--
-- Data for Name: mener_sur
--
INSERT INTO mener_sur(id_piece_depart, id_piece_arrivee) VALUES (1, 2);
INSERT INTO mener_sur(id_piece_depart, id_piece_arrivee) VALUES (2, 1);

--
-- Data for Name: deverouiller
--
INSERT INTO deverrouiller(id_clef, id_piece) VALUES (-1, 2);
