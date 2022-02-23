-- La valeur NULL se test avec IS | IS NOT

-- Quels sont les numéros des livres qui n'ont pas été rendu
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- REQUETES IMBRIQUEES (sur plusieurs tables)
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Quels sont les titres des livres qui n'ont pas été rendu à la bibliothèque ?
SELECT titre FROM livre WHERE id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
+-------------------------+
| titre                   |
+-------------------------+
| Une vie                 |
| Les Trois Mousquetaires |
+-------------------------+


-- EXERCICE : Quels sont les abo n'ayant pas rendus de livre ?

SELECT prenom
FROM abonne 
WHERE id_abonne IN 
    ( SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);

+--------+
| prenom |
+--------+
| Benoit |
| Chloe  |
+--------+

-- Nous aimerions connaitre les numéros des livres que Chloe a emprunté 

SELECT id_livre
FROM emprunt
WHERE id_abonne IN
    (SELECT id_abonne FROM abonne WHERE prenom = 'chloe');
+----------+
| id_livre |
+----------+
|      100 |
|      105 |
+----------+


-- EXERCICE : afficher les prénoms des abonnés ayant emprunté un livre le 11/12/2016 

SELECT prenom 
FROM abonne
WHERE id_abonne IN 
    ( SELECT id_abonne FROM emprunt WHERE date_sortie = '2016-12-11');

+--------+
| prenom |
+--------+
| Chloe  |
+--------+

-- EXERCICE : Combien de livre Guillaume a emprunté de livres à emprunté à la bibliothèque ?

SELECT COUNT(*) AS nombre_livres
FROM emprunt 
WHERE id_abonne IN 
    (SELECT id_abonne FROM abonne WHERE prenom = 'Guillaume' );

+---------------+
| nombre_livres |
+---------------+
|             2 |
+---------------+

-- EXERCICE : Afficher la liste des abonnées ayant déjà emprunté un livre d'Alphonse Daudet 

SELECT prenom
FROM abonne
WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE id_livre IN
    (SELECT id_livre FROM livre WHERE auteur = 'Alphonse Daudet'));
+--------+
| prenom |
+--------+
| Laura  |
+--------+

-- EXERCICE : Nous aimerions connaitres les titres des livres que Chloe a emprunté à la bibliothèques 
SELECT titre , auteur 
FROM livre
WHERE id_livre IN  
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
    (SELECT id_abonne FROM abonne WHERE prenom = 'chloe'));
+-------------------------+-------------------+
| titre                   | auteur            |
+-------------------------+-------------------+
| Une vie                 | GUY DE MAUPASSANT |
| Les Trois Mousquetaires | ALEXANDRE DUMAS   |
+-------------------------+-------------------+

-- EXERCICE : quels sont les livres que chloe n'a pas encore emprunté 

SELECT titre , auteur 
FROM livre
WHERE id_livre NOT IN  
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
    (SELECT id_abonne FROM abonne WHERE prenom = 'chloe'));
+-----------------+-------------------+
| titre           | auteur            |
+-----------------+-------------------+
| Bel-Ami         | GUY DE MAUPASSANT |
| Le p?re Goriot  | HONORE DE BALZAC  |
| Le Petit chose  | ALPHONSE DAUDET   |
| La Reine Margot | ALEXANDRE DUMAS   |
+-----------------+-------------------+

-- EXERCICE : Nous aimerions connaitre les titres des livres que Chloe n'a pas encore rendu 

SELECT titre, auteur
FROM livre 
WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN 
    (SELECT id_abonne from abonne WHERE prenom = 'chloe'));

+-------------------------+-----------------+
| titre                   | auteur          |
+-------------------------+-----------------+
| Les Trois Mousquetaires | ALEXANDRE DUMAS |
+-------------------------+-----------------+

-- EXERCICE : Qui a emprunté le plus de livres à la bibliothèque

SELECT prenom 
FROM abonne 
WHERE  id_abonne LIMIT 1 IN 
    (SELECT id_abonne FROM emprunt WHERE id_emprunt );


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- REQUETES EN JOINTURE (sur plusieurs tables)
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- Différence entre les requetes imbriquées et en jointure :
------------------------------------------------------------
-- Une jointure est possible dans tous les cas.
-- Une requete imbriquée n'est possible que si les informations des colonnes que l'on veut obtenir proviennent que d'une seule table à la fois.

-- Nous aimerions connaitre les dates de sortie et les dates de rendu pour l'abonné Guillaume
SELECT date_sortie, date_rendu, prenom 
FROM emprunt, abonne 
WHERE prenom = 'guillaume' 
AND abonne.id_abonne = emprunt.id_abonne;
-- Nous devons mettre en prefixe des colonnes communes aux tables le nom de la table concernée sinon erreur.
+-------------+------------+-----------+
| date_sortie | date_rendu | prenom    |
+-------------+------------+-----------+
| 2016-12-07  | 2016-12-11 | Guillaume |
| 2016-12-15  | 2016-12-30 | Guillaume |
+-------------+------------+-----------+

-- Il est possible de surnommer les tables (de leur donner des alias)
SELECT date_sortie, date_rendu, prenom 
FROM emprunt e, abonne a 
WHERE prenom = 'guillaume' 
AND a.id_abonne = e.id_abonne;

-- EXERCICE : Aimerions connaitres les dates de sortie et rendu des livres de Alphonse Daudet 
SELECT date_sortie, date_rendu
FROM emprunt, livre
WHERE auteur = 'alphonse Daudet'
AND livre.id_livre = emprunt.id_livre; 
+-------------+------------+
| date_sortie | date_rendu |
+-------------+------------+
| 2016-12-12  | 2016-12-22 |
+-------------+------------+

-- Exercice : qui aemprunté le livre une vie sur l'année 2016 
SELECT prenom , titre , date_sortie , auteur 
FROM abonne, livre, emprunt
WHERE titre = 'une vie'
AND date_sortie  LIKE '2016%'
AND abonne.id_abonne = emprunt.id_abonne
AND emprunt.id_livre = livre.id_livre; 

+-----------+---------+-------------+-------------------+
| prenom    | titre   | date_sortie | auteur            |
+-----------+---------+-------------+-------------------+
| Guillaume | Une vie | 2016-12-07  | GUY DE MAUPASSANT |
| Chloe     | Une vie | 2016-12-11  | GUY DE MAUPASSANT |
+-----------+---------+-------------+-------------------+

-- YEAR() permet de récupérer uniquement l'anéne sur une date 
SELECT YEAR(date_sortie) FROM emprunt;

SELECT prenom , titre , date_sortie , auteur 
FROM abonne, livre, emprunt
WHERE titre = 'une vie'
AND YEAR(date_sortie) = '2016%'
AND abonne.id_abonne = emprunt.id_abonne
AND emprunt.id_livre = livre.id_livre;

-- EXERCICE : nombre de livres emprunté par chaque abonné 

SELECT COUNT(id_emprunt) AS nombre , prenom 
FROM emprunt, abonne
WHERE abonne.id_abonne = emprunt.id_abonne
GROUP BY prenom;
+--------+-----------+
| nombre | prenom    |
+--------+-----------+
|      3 | Benoit    |
|      2 | Chloe     |
|      2 | Guillaume |
|      1 | Laura     |
+--------+-----------+

-- Exercice : qui a emprunté le plus de livre

SELECT  prenom 
FROM emprunt, abonne
WHERE abonne.id_abonne = emprunt.id_abonne
ORDER BY prenom
ASC LIMIT 1;