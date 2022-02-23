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
SELECT COUNT(id_emprunt) AS nombre , prenom 
FROM emprunt, abonne
WHERE abonne.id_abonne = emprunt.id_abonne
GROUP BY emprunt.id_abonne;
ORDER BY COUNT(id_emprunt) DESC;





-- EXERCICE : nous aimerions connaitre le nombre de livre à rendre pour chaque abonné 
SELECT COUNT(id_emprunt) AS nombre,  prenom 
FROM emprunt, abonne
WHERE emprunt.id_abonne = abonne.id_abonne 
AND date_rendu IS NULL 
GROUP BY emprunt.id_abonne;
+--------+--------+
| nombre | prenom |
+--------+--------+
|      1 | Benoit |
|      1 | Chloe  |
+--------+--------+

-- EXERCICE : Qui a emprunté quoi et quand ? 

SELECT prenom , titre , date_sortie
FROM abonne, livre , emprunt
WHERE abonne.id_abonne = emprunt.id_abonne  
AND livre.id_livre = emprunt.id_livre;
+-----------+-------------------------+-------------+
| prenom    | titre                   | date_sortie |
+-----------+-------------------------+-------------+
| Guillaume | Une vie                 | 2016-12-07  |
| Guillaume | La Reine Margot         | 2016-12-15  |
| Benoit    | Bel-Ami                 | 2016-12-07  |
| Benoit    | Les Trois Mousquetaires | 2017-01-02  |
| Benoit    | Une vie                 | 2017-02-20  |
| Chloe     | Une vie                 | 2016-12-11  |
| Chloe     | Les Trois Mousquetaires | 2017-02-15  |
| Laura     | Le Petit chose          | 2016-12-12  |
+-----------+-------------------------+-------------+


---------------------------------------------------------------------
--------------------------------------------------------------------
-- REQUETES EN JOINTURE EXTERNE ( Sans correspondance exigée)
---------------------------------------------------------------------
-- Exercice : afficher la liste des abonnées et les id_livre qu'ils ont emprunté

SELECT prenom , id_livre
FROM abonne , emprunt
WHERE abonne.id_abonne = emprunt.id_abonne;
+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
+-----------+----------+

-- Exercice : Rajoutez-vous dans la table abonne 

INSERT INTO abonne 
(prenom) 
VALUES ('Ergy') ;

-- Affichez tous les abonnés sans exception ainsi que les id_livre qu'ils ont emprunté si c'est le cas !
-- si on déclenche la requête précédente (les prenom et les id_livre) nous ne somme pas présent dans le résultat car nous n'avons pas fait d'emprunt.
-- La jointure externe nous permet de donner la priorité à une table afin de récupérer tout son contenu puis de rajouter le contenu d'autres tables sur la  base de la relation entre ces tables.
SELECT prenom, id_livre FROM abonne LEFT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne; -- priorité sur abonné car à gauche

-----------------

SELECT prenom, id_livre FROM emprunt RIGHT JOIN abonne ON abonne.id_abonne = emprunt.id_abonne; -- priorité sur abonné car à droite

-- On peut utiliser LEFT JOIN ou RIGHT JOIN
-- LEFT JOIN donne la priorité à la table considérée comme étant à gauche dans le sens de lecture de la requete
-- RIGHT JOIN donne la priorité à la table considérée comme étant à droite dans le sens de lecture de la requete

-- Pour préciser la relation entre les deux tables avec un left ou right join, on peut utiliser ON colonne = colonne ou USING(colonne) si elles ont les mêmes noms sur les deux tables.
SELECT prenom, id_livre FROM abonne LEFT JOIN emprunt USING(id_abonne);

+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Benoit    |      101 |
| Chloe     |      100 |
| Laura     |      103 |
| Guillaume |      104 |
| Benoit    |      105 |
| Chloe     |      105 |
| Benoit    |      100 |
| Ergy      |     NULL |
+-----------+----------+

-- EXERCICE : affichez tous les livres sans exception puis les id_abonne qui les ont emprunté si c'est la cas

SELECT titre, id_abonne  
FROM livre 
LEFT JOIN emprunt 
USING (id_livre);
+-------------------------+-----------+
| titre                   | id_abonne |
+-------------------------+-----------+
| Une vie                 |         1 |
| Bel-Ami                 |         2 |
| Une vie                 |         3 |
| Le Petit chose          |         4 |
| La Reine Margot         |         1 |
| Les Trois Mousquetaires |         2 |
| Les Trois Mousquetaires |         3 |
| Une vie                 |         2 |
| Le p?re Goriot          |      NULL |
+-------------------------+-----------+

-- EXERCICE : Donnez le nombre de livre à rendre pour chaque abonné . Les abonnés n'ayant pas fait d'emprunt doivent apparaitre : 
SELECT COUNT(id_emprunt) AS nombre,  prenom 
FROM emprunt, abonne
WHERE emprunt.id_abonne = abonne.id_abonne 
AND date_rendu IS NULL 
GROUP BY emprunt.id_abonne;

SELECT COUNT(id_emprunt) AS nombre, prenom
FROM abonne 
LEFT JOIN emprunt
ON emprunt.id_abonne = abonne.id_abonne
AND date_rendu IS NULL
GROUP BY prenom;

+--------+-----------+
| nombre | prenom    |
+--------+-----------+
|      1 | Benoit    |
|      1 | Chloe     |
|      0 | Ergy      |
|      0 | Guillaume |
|      0 | Laura     |
+--------+-----------+