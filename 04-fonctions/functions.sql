-- FONCTIONS PREDEFINIES (déjà inscrite au langage, le developpeur ne fait que l'exécuter.)
-- En SQL, pas d'espace entre le nom de la fonction et ses parenthèses

SELECT DATABASE(); -- quelle BDD est actuellement utilisée

SELECT CURDATE(); -- date YYYY-MM-DD
SELECT NOW(); -- date et heure YYYY-MM-DD HH:II:SS
SELECT CURTIME(); -- HH:II:SS

-- pour voir les formats disponibles : https://sql.sh/fonctions/date_format
SELECT DATE_FORMAT('2022-02-23', '%d/%m/%Y');

SELECT date_format(date_sortie, '%d/%m/%Y') AS date_fr FROM emprunt;
+------------+
| date_fr    |
+------------+
| 07/12/2016 |
| 07/12/2016 |
| 11/12/2016 |
| 12/12/2016 |
| 15/12/2016 |
| 02/01/2017 |
| 15/02/2017 |
| 20/02/2017 |
+------------+

SELECT DAYNAME('2000-01-01');
+-----------------------+
| DAYNAME('2000-01-01') |
+-----------------------+
| Saturday              |
+-----------------------+

SELECT DAYOFYEAR('2022-02-24');
+-------------------------+
| DAYOFYEAR('2022-02-24') |
+-------------------------+
|                      55 |
+-------------------------+

-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-add
SELECT DATE_ADD('2022-02-24', INTERVAL 31 DAY);
+-----------------------------------------+
| DATE_ADD('2022-02-24', INTERVAL 31 DAY) |
+-----------------------------------------+
| 2022-03-27                              |
+-----------------------------------------+
SELECT DATE_ADD('2022-02-24', INTERVAL 2 YEAR);


INSERT INTO employes (nom, prenom, sexe, salaire, service, date_embauche) VALUES ('Quittard', 'Mathieu', 'm', 3000, 'Web', CURDATE());
SELECT LAST_INSERT_ID(); -- le dernier id (clé primaire) inséré dans une BDD
+------------------+
| LAST_INSERT_ID() |
+------------------+
|              994 |
+------------------+

SELECT CONCAT('a', 'b', 'c');
SELECT CONCAT(nom, ' ', prenom) AS employe FROM employes;
SELECT CONCAT_WS(' - ', 'premier', 'deuxième', 'troisième');
SELECT CONCAT_WS(' - ', nom, prenom, service) FROM employes;
USE bibliotheque;

SELECT CONCAT_WS(' - ', prenom, titre, date_sortie, date_rendu) FROM abonne, emprunt, livre WHERE abonne.id_abonne = emprunt.id_abonne AND emprunt.id_livre = livre.id_livre;
+------------------------------------------------------------+
| CONCAT_WS(' - ', prenom, titre, date_sortie, date_rendu)   |
+------------------------------------------------------------+
| Guillaume - Une vie - 2016-12-07 - 2016-12-11              |
| Guillaume - La Reine Margot - 2016-12-15 - 2016-12-30      |
| Benoit - Bel-Ami  - 2016-12-07 - 2016-12-18                |
| Benoit - Les Trois Mousquetaires - 2017-01-02 - 2017-01-15 |
| Benoit - Une vie - 2017-02-20                              |
| Chloe - Une vie - 2016-12-11 - 2016-12-19                  |
| Chloe - Les Trois Mousquetaires - 2017-02-15               |
| Laura - Le Petit chose - 2016-12-12 - 2016-12-22           |
+------------------------------------------------------------+

SELECT LENGTH('Hello'); -- 5 - la taille de la chaine

SELECT TRIM('            Bonjour a tous           ') AS test; -- permet de supprimer les espaces en début et en fin de chaine (pas au milieu)
+----------------+
| test           |
+----------------+
| Bonjour a tous |
+----------------+

SELECT UPPER('hello'); -- pour passer la chaine en majuscule
SELECT LOWER('BONJOUR'); -- pour passer la chaine en minuscule


SELECT PASSWORD('soleil'); -- pour crypter (c'est un exemple, il faudra privilégier les outils PHP)










