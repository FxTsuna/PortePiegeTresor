--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Debian 11.5-1+deb10u1)
-- Dumped by pg_dump version 11.5 (Debian 11.5-1+deb10u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: chateau; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.chateau (
    id_chateau integer NOT NULL,
    nom_chateau character varying(20) NOT NULL,
    id_createur integer
);


ALTER TABLE public.chateau OWNER TO padawan;

--
-- Name: chateau_id_chateau_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.chateau_id_chateau_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.chateau_id_chateau_seq OWNER TO padawan;

--
-- Name: chateau_id_chateau_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.chateau_id_chateau_seq OWNED BY public.chateau.id_chateau;


--
-- Name: classe; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.classe (
    id_classe integer NOT NULL,
    nom_classe character varying(20) NOT NULL,
    id_createur integer NOT NULL
);


ALTER TABLE public.classe OWNER TO padawan;

--
-- Name: classe_id_classe_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.classe_id_classe_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classe_id_classe_seq OWNER TO padawan;

--
-- Name: classe_id_classe_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.classe_id_classe_seq OWNED BY public.classe.id_classe;


--
-- Name: classe_piege; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.classe_piege (
    id_classe_piege integer NOT NULL,
    nom_classe_piege character varying(20) NOT NULL,
    id_createur integer
);


ALTER TABLE public.classe_piege OWNER TO padawan;

--
-- Name: classe_piege_id_classe_piege_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.classe_piege_id_classe_piege_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classe_piege_id_classe_piege_seq OWNER TO padawan;

--
-- Name: classe_piege_id_classe_piege_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.classe_piege_id_classe_piege_seq OWNED BY public.classe_piege.id_classe_piege;


--
-- Name: objet; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.objet (
    id_objet integer NOT NULL,
    nom_objet character varying(20) NOT NULL,
    id_piece integer,
    id_createur integer
);


ALTER TABLE public.objet OWNER TO padawan;

--
-- Name: clef; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.clef (
    id_clef integer NOT NULL
)
INHERITS (public.objet);


ALTER TABLE public.clef OWNER TO padawan;

--
-- Name: deverrouiller; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.deverrouiller (
    id_clef integer NOT NULL,
    id_piece integer NOT NULL
);


ALTER TABLE public.deverrouiller OWNER TO padawan;

--
-- Name: explorer; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.explorer (
    id_perso integer NOT NULL,
    id_chateau integer NOT NULL,
    date_explo timestamp without time zone NOT NULL
);


ALTER TABLE public.explorer OWNER TO padawan;

--
-- Name: joueur; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.joueur (
    id_joueur integer NOT NULL,
    login character varying(20) NOT NULL,
    mdp character varying(32) NOT NULL
);


ALTER TABLE public.joueur OWNER TO padawan;

--
-- Name: joueur_id_joueur_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.joueur_id_joueur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.joueur_id_joueur_seq OWNER TO padawan;

--
-- Name: joueur_id_joueur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.joueur_id_joueur_seq OWNED BY public.joueur.id_joueur;


--
-- Name: mener_sur; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.mener_sur (
    id_piece_depart integer NOT NULL,
    id_piece_arrivee integer NOT NULL,
    CONSTRAINT pieces_differentes CHECK ((id_piece_depart <> id_piece_arrivee))
);


ALTER TABLE public.mener_sur OWNER TO padawan;

--
-- Name: objet_id_objet_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.objet_id_objet_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.objet_id_objet_seq OWNER TO padawan;

--
-- Name: objet_id_objet_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.objet_id_objet_seq OWNED BY public.objet.id_objet;


--
-- Name: personnage; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.personnage (
    id_perso integer NOT NULL,
    nom_perso character varying(20) NOT NULL,
    vitalite_max integer NOT NULL,
    vitalite integer NOT NULL,
    id_classe integer,
    id_createur integer,
    CONSTRAINT vitalite_interval CHECK (((vitalite >= 0) AND (vitalite <= vitalite_max))),
    CONSTRAINT vitalite_positive CHECK ((vitalite_max > 0))
);


ALTER TABLE public.personnage OWNER TO padawan;

--
-- Name: personnage_id_perso_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.personnage_id_perso_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personnage_id_perso_seq OWNER TO padawan;

--
-- Name: personnage_id_perso_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.personnage_id_perso_seq OWNED BY public.personnage.id_perso;


--
-- Name: piece; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.piece (
    id_piece integer NOT NULL,
    nom_piece character varying(20) NOT NULL,
    descriptif character varying(150),
    indices character varying(50) NOT NULL,
    id_chateau integer,
    id_createur integer
);


ALTER TABLE public.piece OWNER TO padawan;

--
-- Name: piece_id_piece_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.piece_id_piece_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.piece_id_piece_seq OWNER TO padawan;

--
-- Name: piece_id_piece_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.piece_id_piece_seq OWNED BY public.piece.id_piece;


--
-- Name: piege; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.piege (
    id_piege integer NOT NULL,
    nom_piege character varying(20) NOT NULL,
    id_piece integer,
    id_classe_piege integer,
    degats integer NOT NULL,
    id_createur integer,
    CONSTRAINT valeur_degats CHECK ((degats > 0))
);


ALTER TABLE public.piege OWNER TO padawan;

--
-- Name: piege_id_piege_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.piege_id_piege_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.piege_id_piege_seq OWNER TO padawan;

--
-- Name: piege_id_piege_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.piege_id_piege_seq OWNED BY public.piege.id_piege;


--
-- Name: posseder; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.posseder (
    id_objet integer NOT NULL,
    id_possesseur integer NOT NULL
);


ALTER TABLE public.posseder OWNER TO padawan;

--
-- Name: potion; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.potion (
    vie_rendue integer NOT NULL,
    CONSTRAINT valeur_vie_rendue CHECK ((vie_rendue > 0))
)
INHERITS (public.objet);


ALTER TABLE public.potion OWNER TO padawan;

--
-- Name: reduire; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.reduire (
    id_classe integer NOT NULL,
    id_classe_piege integer NOT NULL,
    reduction integer NOT NULL,
    CONSTRAINT reduction_value CHECK ((reduction > 0))
);


ALTER TABLE public.reduire OWNER TO padawan;

--
-- Name: reussir; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.reussir (
    id_perso integer NOT NULL,
    id_chateau integer NOT NULL,
    date_reu date NOT NULL
);


ALTER TABLE public.reussir OWNER TO padawan;

--
-- Name: se_trouver; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.se_trouver (
    id_piece integer NOT NULL,
    id_perso integer NOT NULL,
    date_trouv timestamp without time zone NOT NULL
);


ALTER TABLE public.se_trouver OWNER TO padawan;

--
-- Name: sortie; Type: TABLE; Schema: public; Owner: padawan
--

CREATE TABLE public.sortie (
    id_sortie integer NOT NULL
)
INHERITS (public.piece);


ALTER TABLE public.sortie OWNER TO padawan;

--
-- Name: sortie_id_sortie_seq; Type: SEQUENCE; Schema: public; Owner: padawan
--

CREATE SEQUENCE public.sortie_id_sortie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sortie_id_sortie_seq OWNER TO padawan;

--
-- Name: sortie_id_sortie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: padawan
--

ALTER SEQUENCE public.sortie_id_sortie_seq OWNED BY public.sortie.id_sortie;


--
-- Name: chateau id_chateau; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.chateau ALTER COLUMN id_chateau SET DEFAULT nextval('public.chateau_id_chateau_seq'::regclass);


--
-- Name: classe id_classe; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe ALTER COLUMN id_classe SET DEFAULT nextval('public.classe_id_classe_seq'::regclass);


--
-- Name: classe_piege id_classe_piege; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe_piege ALTER COLUMN id_classe_piege SET DEFAULT nextval('public.classe_piege_id_classe_piege_seq'::regclass);


--
-- Name: clef id_objet; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.clef ALTER COLUMN id_objet SET DEFAULT nextval('public.objet_id_objet_seq'::regclass);


--
-- Name: joueur id_joueur; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.joueur ALTER COLUMN id_joueur SET DEFAULT nextval('public.joueur_id_joueur_seq'::regclass);


--
-- Name: objet id_objet; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.objet ALTER COLUMN id_objet SET DEFAULT nextval('public.objet_id_objet_seq'::regclass);


--
-- Name: personnage id_perso; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.personnage ALTER COLUMN id_perso SET DEFAULT nextval('public.personnage_id_perso_seq'::regclass);


--
-- Name: piece id_piece; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piece ALTER COLUMN id_piece SET DEFAULT nextval('public.piece_id_piece_seq'::regclass);


--
-- Name: piege id_piege; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piege ALTER COLUMN id_piege SET DEFAULT nextval('public.piege_id_piege_seq'::regclass);


--
-- Name: potion id_objet; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.potion ALTER COLUMN id_objet SET DEFAULT nextval('public.objet_id_objet_seq'::regclass);


--
-- Name: sortie id_piece; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.sortie ALTER COLUMN id_piece SET DEFAULT nextval('public.piece_id_piece_seq'::regclass);


--
-- Name: sortie id_sortie; Type: DEFAULT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.sortie ALTER COLUMN id_sortie SET DEFAULT nextval('public.sortie_id_sortie_seq'::regclass);


--
-- Data for Name: chateau; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.chateau (id_chateau, nom_chateau, id_createur) FROM stdin;
1	forteresse	1
2	chateau	1
3	bastille	3
4	Campus Descartes	1
\.


--
-- Data for Name: classe; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.classe (id_classe, nom_classe, id_createur) FROM stdin;
1	genie	1
2	alchimiste	1
3	genie	2
4	mecanicien	3
5	dompteur	6
6	sorcier	8
7	xelor	3
8	yasuo	8
\.


--
-- Data for Name: classe_piege; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.classe_piege (id_classe_piege, nom_classe_piege, id_createur) FROM stdin;
1	enigme mortelle	1
2	poison	1
3	enigme mortelle	2
4	piege mecanique	3
5	monstre	8
6	magique	6
7	temporelle	6
8	bronze trap	3
\.


--
-- Data for Name: clef; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.clef (id_objet, nom_objet, id_piece, id_createur, id_clef) FROM stdin;
9	clef de la prison	21	1	-1
\.


--
-- Data for Name: deverrouiller; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.deverrouiller (id_clef, id_piece) FROM stdin;
-1	2
\.


--
-- Data for Name: explorer; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.explorer (id_perso, id_chateau, date_explo) FROM stdin;
1	1	2019-12-03 13:03:17
1	2	2018-12-03 17:00:01
\.


--
-- Data for Name: joueur; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.joueur (id_joueur, login, mdp) FROM stdin;
1	lcreanto	60d9de75012d87dad78d9fba9076d397
2	fxu	1a6327fe3522267c3ad5c9240bfdfe82
3	upem	5259ebb16afdf8a26cc92e78e96c02de
4	tsu	tsunts
5	4head	pepega
6	higahashier	riyumi
7	ezriel	xanto
8	keredo	vivi
\.


--
-- Data for Name: mener_sur; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.mener_sur (id_piece_depart, id_piece_arrivee) FROM stdin;
1	2
2	1
\.


--
-- Data for Name: objet; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.objet (id_objet, nom_objet, id_piece, id_createur) FROM stdin;
1	morceau de verre	1	1
2	oreiller	3	2
3	fourchette	4	3
4	casque gaming	10	7
10	Souris cassée	12	1
\.


--
-- Data for Name: personnage; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.personnage (id_perso, nom_perso, vitalite_max, vitalite, id_classe, id_createur) FROM stdin;
1	zwendo	30	25	1	1
2	fxtsuna	24	12	3	2
3	etudiant en L2	10	10	3	3
4	zbeub	15	10	7	4
5	neocrest	20	15	8	5
6	shade	30	30	6	6
7	helly	50	45	5	8
\.


--
-- Data for Name: piece; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.piece (id_piece, nom_piece, descriptif, indices, id_chateau, id_createur) FROM stdin;
1	hall	la premiere piece du chateau	regardez sous le tapis	1	1
2	prison	l endroit ou est enferme le dragon	la trosieme cellule semble etrange	1	1
3	chambre	la chambre du roi	la lumiere est la clef	2	2
4	cuisines	on y prepare les meilleurs mets	coupez les gateaux	3	3
5	zoo	on y prepare les meilleurs mets	coupez les gateaux	3	8
6	cage	on y prepare les meilleurs mets	coupez les gateaux	3	6
7	bibliothèque	on y prepare les meilleurs mets	coupez les gateaux	3	6
8	cave	on y prepare les meilleurs mets	coupez les gateaux	3	8
9	chambre secrète	on y prepare les meilleurs mets	coupez les gateaux	3	6
10	salle gaming	on y prepare les meilleurs joueurs	aegn	3	8
12	Clément Ader	Salle de tp\r\n	une souris est cassée	4	1
13	qsqsqs	qsdqsd	sqdqsd	4	1
\.


--
-- Data for Name: piege; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.piege (id_piege, nom_piege, id_piece, id_classe_piege, degats, id_createur) FROM stdin;
1	enigme du sphinx	1	1	100	1
2	gaz moutarde	2	2	10	1
3	enigme de toto	3	3	2	2
4	piege a ours	4	3	15	3
5	hydre	5	5	30	8
6	ours	6	5	20	8
7	explosion arcanique	7	6	30	6
8	néant distordu	8	7	100	6
9	salle du temps	9	7	15	6
10	salle du fer 4	10	8	50	3
11	TP6 BIS BDD	12	1	100	1
12	énoncé eval C2I	12	1	25	1
\.


--
-- Data for Name: posseder; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.posseder (id_objet, id_possesseur) FROM stdin;
\.


--
-- Data for Name: potion; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.potion (id_objet, nom_objet, id_piece, id_createur, vie_rendue) FROM stdin;
5	potion amelioree	3	2	2
6	potion au choux	4	3	3
7	potion de l esprit	7	6	10
8	potion feed 	10	8	5
\.


--
-- Data for Name: reduire; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.reduire (id_classe, id_classe_piege, reduction) FROM stdin;
1	1	100
1	2	5
3	2	1
4	4	10
5	5	20
6	6	30
7	7	15
8	8	50
\.


--
-- Data for Name: reussir; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.reussir (id_perso, id_chateau, date_reu) FROM stdin;
1	1	2019-10-20
1	1	2019-10-23
1	2	2019-10-20
2	1	2019-10-20
\.


--
-- Data for Name: se_trouver; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.se_trouver (id_piece, id_perso, date_trouv) FROM stdin;
1	1	2018-12-03 18:25:14
2	1	2018-12-03 18:26:14
1	1	2018-12-03 18:27:14
2	1	2019-12-03 18:31:14
\.


--
-- Data for Name: sortie; Type: TABLE DATA; Schema: public; Owner: padawan
--

COPY public.sortie (id_piece, nom_piece, descriptif, indices, id_chateau, id_createur, id_sortie) FROM stdin;
11	sortie	vous avez reussi	bravo	1	1	1
\.


--
-- Name: chateau_id_chateau_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.chateau_id_chateau_seq', 5, true);


--
-- Name: classe_id_classe_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.classe_id_classe_seq', 8, true);


--
-- Name: classe_piege_id_classe_piege_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.classe_piege_id_classe_piege_seq', 8, true);


--
-- Name: joueur_id_joueur_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.joueur_id_joueur_seq', 8, true);


--
-- Name: objet_id_objet_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.objet_id_objet_seq', 10, true);


--
-- Name: personnage_id_perso_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.personnage_id_perso_seq', 7, true);


--
-- Name: piece_id_piece_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.piece_id_piece_seq', 13, true);


--
-- Name: piege_id_piege_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.piege_id_piege_seq', 12, true);


--
-- Name: sortie_id_sortie_seq; Type: SEQUENCE SET; Schema: public; Owner: padawan
--

SELECT pg_catalog.setval('public.sortie_id_sortie_seq', 1, true);


--
-- Name: chateau chateau_nom_chateau_key; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.chateau
    ADD CONSTRAINT chateau_nom_chateau_key UNIQUE (nom_chateau);


--
-- Name: chateau chateau_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.chateau
    ADD CONSTRAINT chateau_pkey PRIMARY KEY (id_chateau);


--
-- Name: classe_piege classe_piege_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe_piege
    ADD CONSTRAINT classe_piege_pkey PRIMARY KEY (id_classe_piege);


--
-- Name: classe classe_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe
    ADD CONSTRAINT classe_pkey PRIMARY KEY (id_classe);


--
-- Name: clef clef_id_clef_key; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.clef
    ADD CONSTRAINT clef_id_clef_key UNIQUE (id_clef);


--
-- Name: deverrouiller deverrouiller_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.deverrouiller
    ADD CONSTRAINT deverrouiller_pkey PRIMARY KEY (id_clef, id_piece);


--
-- Name: explorer explorer_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.explorer
    ADD CONSTRAINT explorer_pkey PRIMARY KEY (id_perso, id_chateau, date_explo);


--
-- Name: joueur joueur_login_key; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.joueur
    ADD CONSTRAINT joueur_login_key UNIQUE (login);


--
-- Name: joueur joueur_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.joueur
    ADD CONSTRAINT joueur_pkey PRIMARY KEY (id_joueur);


--
-- Name: mener_sur mener_sur_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.mener_sur
    ADD CONSTRAINT mener_sur_pkey PRIMARY KEY (id_piece_depart, id_piece_arrivee);


--
-- Name: objet objet_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.objet
    ADD CONSTRAINT objet_pkey PRIMARY KEY (id_objet);


--
-- Name: personnage personnage_nom_perso_key; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.personnage
    ADD CONSTRAINT personnage_nom_perso_key UNIQUE (nom_perso);


--
-- Name: personnage personnage_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.personnage
    ADD CONSTRAINT personnage_pkey PRIMARY KEY (id_perso);


--
-- Name: piece piece_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piece
    ADD CONSTRAINT piece_pkey PRIMARY KEY (id_piece);


--
-- Name: piege piege_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piege
    ADD CONSTRAINT piege_pkey PRIMARY KEY (id_piege);


--
-- Name: posseder posseder_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.posseder
    ADD CONSTRAINT posseder_pkey PRIMARY KEY (id_objet, id_possesseur);


--
-- Name: reduire reduire_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.reduire
    ADD CONSTRAINT reduire_pkey PRIMARY KEY (id_classe, id_classe_piege);


--
-- Name: reussir reussir_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.reussir
    ADD CONSTRAINT reussir_pkey PRIMARY KEY (id_perso, id_chateau, date_reu);


--
-- Name: se_trouver se_trouver_pkey; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.se_trouver
    ADD CONSTRAINT se_trouver_pkey PRIMARY KEY (id_piece, id_perso, date_trouv);


--
-- Name: sortie sortie_id_sortie_key; Type: CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.sortie
    ADD CONSTRAINT sortie_id_sortie_key UNIQUE (id_sortie);


--
-- Name: chateau chateau_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.chateau
    ADD CONSTRAINT chateau_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: classe classe_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe
    ADD CONSTRAINT classe_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: classe_piege classe_piege_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.classe_piege
    ADD CONSTRAINT classe_piege_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deverrouiller deverrouiller_id_clef; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.deverrouiller
    ADD CONSTRAINT deverrouiller_id_clef FOREIGN KEY (id_clef) REFERENCES public.clef(id_clef) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deverrouiller deverrouiller_id_piece; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.deverrouiller
    ADD CONSTRAINT deverrouiller_id_piece FOREIGN KEY (id_piece) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: explorer explorer_id_chateau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.explorer
    ADD CONSTRAINT explorer_id_chateau_fkey FOREIGN KEY (id_chateau) REFERENCES public.chateau(id_chateau) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: explorer explorer_id_perso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.explorer
    ADD CONSTRAINT explorer_id_perso_fkey FOREIGN KEY (id_perso) REFERENCES public.personnage(id_perso) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mener_sur mener_sur_id_piece_arrivee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.mener_sur
    ADD CONSTRAINT mener_sur_id_piece_arrivee_fkey FOREIGN KEY (id_piece_arrivee) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mener_sur mener_sur_id_piece_depart_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.mener_sur
    ADD CONSTRAINT mener_sur_id_piece_depart_fkey FOREIGN KEY (id_piece_depart) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: objet objet_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.objet
    ADD CONSTRAINT objet_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: objet objet_id_piece_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.objet
    ADD CONSTRAINT objet_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personnage personnage_id_classe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.personnage
    ADD CONSTRAINT personnage_id_classe_fkey FOREIGN KEY (id_classe) REFERENCES public.classe(id_classe) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: personnage personnage_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.personnage
    ADD CONSTRAINT personnage_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: piece piece_id_chateau_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piece
    ADD CONSTRAINT piece_id_chateau_fkey FOREIGN KEY (id_chateau) REFERENCES public.chateau(id_chateau) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: piece piece_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piece
    ADD CONSTRAINT piece_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: piege piege_id_classe_piege_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piege
    ADD CONSTRAINT piege_id_classe_piege_fkey FOREIGN KEY (id_classe_piege) REFERENCES public.classe_piege(id_classe_piege) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: piege piege_id_createur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piege
    ADD CONSTRAINT piege_id_createur_fkey FOREIGN KEY (id_createur) REFERENCES public.joueur(id_joueur) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: piege piege_id_piece_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.piege
    ADD CONSTRAINT piege_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posseder posseder_id_objet_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.posseder
    ADD CONSTRAINT posseder_id_objet_fkey FOREIGN KEY (id_objet) REFERENCES public.objet(id_objet) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: posseder posseder_id_perso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.posseder
    ADD CONSTRAINT posseder_id_perso_fkey FOREIGN KEY (id_possesseur) REFERENCES public.personnage(id_perso) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reduire reduire_id_classe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.reduire
    ADD CONSTRAINT reduire_id_classe_fkey FOREIGN KEY (id_classe) REFERENCES public.classe(id_classe) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reduire reduire_id_classe_piege; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.reduire
    ADD CONSTRAINT reduire_id_classe_piege FOREIGN KEY (id_classe_piege) REFERENCES public.classe_piege(id_classe_piege) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: se_trouver se_trouver_id_perso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.se_trouver
    ADD CONSTRAINT se_trouver_id_perso_fkey FOREIGN KEY (id_perso) REFERENCES public.personnage(id_perso) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: se_trouver se_trouver_id_piece_fkey; Type: FK CONSTRAINT; Schema: public; Owner: padawan
--

ALTER TABLE ONLY public.se_trouver
    ADD CONSTRAINT se_trouver_id_piece_fkey FOREIGN KEY (id_piece) REFERENCES public.piece(id_piece) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

