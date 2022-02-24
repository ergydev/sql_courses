-- ceci est un commentaire sur une seule ligne
# ceci est un commentaire sur une seule ligne 
/*
- Pour ouvrir la console MySQL :
- Sur MAMP : lancer le terminal puis copier/coller la ligne suivante : 
/Applications/MAMP/Library/bin/mysql -u root -p
- puis taper le mdp suivant : root (attention, ce ne sera pas visible) puis valider.

- Sur XAMPP : lancer le shell (bouton à droite sur le control panel de xampp)
- Puis copier/coller les deux lignes suivantes :
cd c:\xampp\mysql\bin
mysql.exe -u root
- La console nous demande le mdp, il n'y a en pas sur xampp, il suffit de valider.

- Sur WAMP : clic gauche sur l'icone de WAMP puis aller dans > MySQL > Console MySQL et valider car il n'y a pas de mdp
*/

/*
Exemple de requete :
--------------------
SELECT nom, prenom FROM utilisateur WHERE pseudo = 'admin';

SELECT : renvoie moi | affiche moi
FROM : de la table
WHERE : à la condition que

Par convention d'écriture, les mots clé doivent être en majuscule.
Chaque instruction doit se terminer par un point virgule ;
Les données de type chaine de caractères doivent être entre '' ou "" (pas de différence entre les deux)
*/

-- DOC : sql.sh


-- pour créer un BDD
CREATE DATABASE nom_de_la_bdd;
CREATE DATABASE entreprise;

-- Pour voir les BDD, tables, warnings
SHOW DATABASES;
SHOW TABLES;
SHOW WARNINGS;

-- Pour se positionner sur une BDD afin de travailler dessus :
USE nom_de_la_bdd;
USE entreprise;

-- Pour supprimer une BDD, table :
DROP DATABASE nom_de_la_bdd;
DROP TABLE nom_de_la_table;

-- Pour vider les données d'une table (on garde la structure de la table) :
TRUNCATE nom_de_la_table;

-- Pour voir la structure d'une table :
DESC nom_de_la_table;

-- Copier coller le contenu du fichier entreprise.sql dans la console afin de créer la base entreprise et son contenu 

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- REQUETES DE SELECTION (question : on ne touche pas aux données)
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Affichage complet de la table employes
SELECT id_employes, nom, prenom, salaire, sexe, date_embauche, service FROM employes;
+-------------+----------+-------------+---------+------+---------------+---------------+
| id_employes | nom      | prenom      | salaire | sexe | date_embauche | service       |
+-------------+----------+-------------+---------+------+---------------+---------------+
|         350 | Laborde  | Jean-pierre |    5000 | m    | 2010-12-09    | direction     |
|         388 | Gallet   | Clement     |    2300 | m    | 2010-12-15    | commercial    |
|         415 | Winter   | Thomas      |    3550 | m    | 2011-05-03    | commercial    |
|         417 | Dubar    | Chloe       |    1900 | f    | 2011-09-05    | production    |
|         491 | Fellier  | Elodie      |    1600 | f    | 2011-11-22    | secretariat   |
|         509 | Grand    | Fabrice     |    2900 | m    | 2011-12-30    | comptabilite  |
|         547 | Collier  | Melanie     |    3100 | f    | 2012-01-08    | commercial    |
|         592 | Blanchet | Laura       |    4500 | f    | 2012-05-09    | direction     |
|         627 | Miller   | Guillaume   |    1900 | m    | 2012-07-02    | commercial    |
|         655 | Perrin   | Celine      |    2700 | f    | 2012-09-10    | commercial    |
|         699 | Cottet   | Julien      |    1390 | m    | 2013-01-05    | secretariat   |
|         701 | Vignal   | Mathieu     |    2500 | m    | 2013-04-03    | informatique  |
|         739 | Desprez  | Thierry     |    1500 | m    | 2013-07-17    | secretariat   |
|         780 | Thoyer   | Amandine    |    2100 | f    | 2014-01-23    | communication |
|         802 | Durand   | Damien      |    2250 | m    | 2014-07-05    | informatique  |
|         854 | Chevel   | Daniel      |    3100 | m    | 2015-09-28    | informatique  |
|         876 | Martin   | Nathalie    |    3550 | f    | 2016-01-12    | juridique     |
|         900 | Lagarde  | Benoit      |    2550 | m    | 2016-06-03    | production    |
|         933 | Sennard  | Emilie      |    1800 | f    | 2017-01-11    | commercial    |
|         990 | Lafaye   | Stephanie   |    1775 | f    | 2017-03-01    | assistant     |
+-------------+----------+-------------+---------+------+---------------+---------------+

-- Même chose avec le raccourci * (ALL)
SELECT * FROM employes;

-- Affichage des prenoms et des noms de la table employes
SELECT prenom, nom FROM employes;

-- EXERCICE :
-- Affichez les différents services de la table employes
SELECT service FROM employes;
-- Pour éviter les doublons : DISTINCT
SELECT DISTINCT service FROM employes;
+---------------+
| service       |
+---------------+
| direction     |
| commercial    |
| production    |
| secretariat   |
| comptabilite  |
| informatique  |
| communication |
| juridique     |
| assistant     |
+---------------+

-- CONDITIONS : WHERE (à la condition que)
-- Affichage des employes du service informatique
SELECT nom, prenom, service FROM employes WHERE service = 'informatique';
+--------+---------+--------------+
| nom    | prenom  | service      |
+--------+---------+--------------+
| Vignal | Mathieu | informatique |
| Durand | Damien  | informatique |
| Chevel | Daniel  | informatique |
+--------+---------+--------------+

-- Affichage des employes ayant été recruté entre le 01/01/2015 et aujourd'hui
-- BETWEEN
SELECT * FROM employes WHERE date_embauche BETWEEN '2015-01-01' AND '2022-02-22';
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         854 | Daniel    | Chevel  | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie  | Martin  | f    | juridique    | 2016-01-12    |    3550 |
|         900 | Benoit    | Lagarde | m    | production   | 2016-06-03    |    2550 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
|         990 | Stephanie | Lafaye  | f    | assistant    | 2017-03-01    |    1775 |
+-------------+-----------+---------+------+--------------+---------------+---------+

-- selon alphabet
SELECT * FROM employes WHERE nom BETWEEN 'a' AND 'm';

-- Pour obtenir la date du jour : 
-- CURDATE()
SELECT CURDATE();
+------------+
| CURDATE()  |
+------------+
| 2022-02-22 |
+------------+

SELECT * FROM employes WHERE date_embauche BETWEEN '2015-01-01' AND CURDATE();

-- Pour avoir la date du jour et aussi heure minute seconde :
-- NOW()
SELECT NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2022-02-22 11:21:05 |
+---------------------+

-- LIKE : la valeur approchante
-- Liste des employes ayant un prénom qui commence par la lettre s
SELECT prenom FROM employes WHERE prenom LIKE 's%';
+-----------+
| prenom    |
+-----------+
| Stephanie |
+-----------+
-- employes ayant un prenom qui finit par ie
SELECT prenom FROM employes WHERE prenom LIKE '%ie';
+-----------+
| prenom    |
+-----------+
| Elodie    |
| Melanie   |
| Nathalie  |
| Emilie    |
| Stephanie |
+-----------+
-- employes ayant un prenom contenant ie (au début, à la fin, n'importe où)
SELECT prenom FROM employes WHERE prenom LIKE '%ie%';
+-------------+
| prenom      |
+-------------+
| Jean-pierre |
| Elodie      |
| Melanie     |
| Julien      |
| Mathieu     |
| Thierry     |
| Damien      |
| Daniel      |
| Nathalie    |
| Emilie      |
| Stephanie   |
+-------------+

/*
id      type        cp
-------------------------
23      appart      75018
28      appart      75009
35      appart      13001
36      appart      34000
42      appart      75020
45      appart      75001

75
SELECT * FROM appartement WHERE cp = '75'; => 0 résultat
SELECT * FROM appartement WHERE cp LIKE '75%'; => 4 résultats
*/

-- affichage des employes sauf ceux du service informatique (exclusion)
SELECT * FROM employes WHERE service != 'informatique';


-- Récupération des employes ayant un salaire supérieur à 3000
SELECT * FROM employes WHERE salaire > 3000;
SELECT * FROM employes WHERE salaire > '3000';
+-------------+-------------+----------+------+--------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service      | date_embauche | salaire |
+-------------+-------------+----------+------+--------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction    | 2010-12-09    |    5000 |
|         415 | Thomas      | Winter   | m    | commercial   | 2011-05-03    |    3550 |
|         547 | Melanie     | Collier  | f    | commercial   | 2012-01-08    |    3100 |
|         592 | Laura       | Blanchet | f    | direction    | 2012-05-09    |    4500 |
|         854 | Daniel      | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique    | 2016-01-12    |    3550 |
+-------------+-------------+----------+------+--------------+---------------+---------+

/*
Opérateurs de comparaison :
---------------------------
=   est égal à
!=  est différent de. Autre écriture possible <>
>   sructement supérieur
>=  supérieur ou égal
<   strictement inférieur
<=  inférieur ou égal
*/

-- ORDER BY : pour ordonner les résultats
-- Affichage des employes en ordre alphabétique sur le nom :
SELECT * FROM employes ORDER BY nom;
SELECT * FROM employes ORDER BY nom ASC; -- ASC : ascendant (cas pas défaut)
-- ordre inversé : DESC : descendant
SELECT * FROM employes ORDER BY nom DESC;

SELECT nom, prenom, salaire FROM employes ORDER BY salaire DESC;

-- il est possible d'ordonner sur plusieurs colonnes.
SELECT nom, prenom, salaire FROM employes ORDER BY salaire DESC, nom DESC;

-- Pour limiter le nombre de résultat : (exemple : pagination)
-- LIMIT 
-- LIMIT position_de_depart, nb_de_ligne;
-- LIMIT nb_de_ligne; (position de départ toujours au début)

-- Affichage des employes 3 par 3
SELECT * FROM employes LIMIT 0, 3;
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+

SELECT * FROM employes LIMIT 3, 3;
+-------------+---------+---------+------+--------------+---------------+---------+
| id_employes | prenom  | nom     | sexe | service      | date_embauche | salaire |
+-------------+---------+---------+------+--------------+---------------+---------+
|         417 | Chloe   | Dubar   | f    | production   | 2011-09-05    |    1900 |
|         491 | Elodie  | Fellier | f    | secretariat  | 2011-11-22    |    1600 |
|         509 | Fabrice | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
+-------------+---------+---------+------+--------------+---------------+---------+

SELECT * FROM employes LIMIT 6, 3;
+-------------+-----------+----------+------+------------+---------------+---------+
| id_employes | prenom    | nom      | sexe | service    | date_embauche | salaire |
+-------------+-----------+----------+------+------------+---------------+---------+
|         547 | Melanie   | Collier  | f    | commercial | 2012-01-08    |    3100 |
|         592 | Laura     | Blanchet | f    | direction  | 2012-05-09    |    4500 |
|         627 | Guillaume | Miller   | m    | commercial | 2012-07-02    |    1900 |
+-------------+-----------+----------+------+------------+---------------+---------+

-- uniquement la premiere ligne :
SELECT * FROM employes LIMIT 1;
+-------------+-------------+---------+------+-----------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service   | date_embauche | salaire |
+-------------+-------------+---------+------+-----------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction | 2010-12-09    |    5000 |
+-------------+-------------+---------+------+-----------+---------------+---------+

-- Affichage du salaire annuel
SELECT nom, service, salaire * 12 FROM employes;
-- Il est possible de donner un alias (surnom) à nos colonnes :
SELECT nom, service, salaire * 12 AS salaire_annuel FROM employes;
SELECT nom, service, salaire * 12 AS 'Salaire annuel' FROM employes;

-- SUM() : la somme
-- Affichage de la masse salariale
SELECT SUM(salaire * 12) FROM employes; 
+-------------------+
| SUM(salaire * 12) |
+-------------------+
|            623580 |
+-------------------+
SELECT SUM(salaire * 12) AS masse_salariale FROM employes;
+-----------------+
| masse_salariale |
+-----------------+
|          623580 |
+-----------------+
-- CONCAT() permet de faire une concaténation de chaque valeur fournie séparée par une virgule.
SELECT CONCAT(SUM(salaire * 12), '€') AS masse_salariale FROM employes;
SELECT CONCAT(SUM(salaire * 12), ' - ', CURDATE()) AS masse_salariale FROM employes;

-- AVG() : la moyenne
-- quel est le salaire moyen de l'entreprise
SELECT AVG(salaire) AS salaire_moyen FROM employes;
+---------------+
| salaire_moyen |
+---------------+
|     2598.2500 |
+---------------+

-- ROUND() : pour arrondir
-- arrondi à l'entier :
SELECT ROUND(AVG(salaire)) AS salaire_moyen FROM employes;
-- arrondi avec 2 décimales (le deuxième argument de ROUND() représente le nombre de décimales acceptées)
SELECT ROUND(AVG(salaire), 2) AS salaire_moyen FROM employes;

-- COUNT() : pour compter le nombre de ligne
-- combien d'homme
SELECT COUNT(*) AS nombre_homme FROM employes WHERE sexe = 'm';
+--------------+
| nombre_homme |
+--------------+
|           11 |
+--------------+
-- combien de femme
SELECT COUNT(*) AS nombre_femme FROM employes WHERE sexe = 'f';
+--------------+
| nombre_femme |
+--------------+
|            9 |
+--------------+

-- MIN() | MAX()
-- salaire minimal :
SELECT MIN(salaire) FROM employes;
+--------------+
| MIN(salaire) |
+--------------+
|         1390 |
+--------------+

-- EXERCICE : affichez le salaire minimum, le nom et le prenom de la personne ayant ce salaire :
SELECT nom, prenom, MIN(salaire) FROM employes; -- ⚠ résultat incohérent.

-- Pour obtenir un bon résultat : 2 possibilités :
-- Avec une requete imbriquée
SELECT nom, prenom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);
+--------+--------+---------+
| nom    | prenom | salaire |
+--------+--------+---------+
| Cottet | Julien |    1390 |
+--------+--------+---------+

-- avec ORDER BY et LIMIT
SELECT nom, prenom, salaire FROM employes ORDER BY salaire LIMIT 1;
+--------+--------+---------+
| nom    | prenom | salaire |
+--------+--------+---------+
| Cottet | Julien |    1390 |
+--------+--------+---------+


-- IN () | NOT IN ()
-- les employes du service commercial et informatique
SELECT nom, prenom, service FROM employes WHERE service IN ('informatique', 'commercial');
+---------+-----------+--------------+
| nom     | prenom    | service      |
+---------+-----------+--------------+
| Gallet  | Clement   | commercial   |
| Winter  | Thomas    | commercial   |
| Collier | Melanie   | commercial   |
| Miller  | Guillaume | commercial   |
| Perrin  | Celine    | commercial   |
| Vignal  | Mathieu   | informatique |
| Durand  | Damien    | informatique |
| Chevel  | Daniel    | informatique |
| Sennard | Emilie    | commercial   |
+---------+-----------+--------------+
-- exclusion
SELECT nom, prenom, service FROM employes WHERE service NOT IN ('informatique', 'commercial');

-- Plusieurs conditions : AND 
-- affichage des commerciaux ayant un salaire supérieur à 2000
SELECT * FROM employes WHERE service = 'commercial' AND salaire > 2000;
+-------------+---------+---------+------+------------+---------------+---------+
| id_employes | prenom  | nom     | sexe | service    | date_embauche | salaire |
+-------------+---------+---------+------+------------+---------------+---------+
|         388 | Clement | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas  | Winter  | m    | commercial | 2011-05-03    |    3550 |
|         547 | Melanie | Collier | f    | commercial | 2012-01-08    |    3100 |
|         655 | Celine  | Perrin  | f    | commercial | 2012-09-10    |    2700 |
+-------------+---------+---------+------+------------+---------------+---------+

-- L'une ou l'autre d'un ensemble  de valeur : OR 
-- Affichage des employes du service production gagnant un salaire de 1900 ou 2300

SELECT * FROM employes WHERE service = 'production' AND (salaire = 1900 OR salaire = 2300);
+-------------+--------+-------+------+------------+---------------+---------+
| id_employes | prenom | nom   | sexe | service    | date_embauche | salaire |
+-------------+--------+-------+------+------------+---------------+---------+
|         417 | Chloe  | Dubar | f    | production | 2011-09-05    |    1900 |
+-------------+--------+-------+------+------------+---------------+---------+

-- GROUP BY
-- Affichage de nombre d'employé par service 
SELECT service,
COUNT(*) as nombre
FROM employes
GROUP BY service;
+---------------+--------+
| service       | nombre |
+---------------+--------+
| assistant     |      1 |
| commercial    |      6 |
| communication |      1 |
| comptabilite  |      1 |
| direction     |      2 |
| informatique  |      3 |
| juridique     |      1 |
| production    |      2 |
| secretariat   |      3 |
+---------------+--------+

-- Il est possible de mettre une condition sur le GROUP BY 
-- HAVING 
-- Affichage des service uniquement s'ils ont plus de 2 employés 
SELECT service,
COUNT(*) as nombre
FROM employes
GROUP BY service
HAVING COUNT(*) > 2;
+--------------+--------+
| service      | nombre |
+--------------+--------+
| commercial   |      6 |
| informatique |      3 |
| secretariat  |      3 |
+--------------+--------+


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- REQUETES D'ENREGISTREMENT : INSERT INTO (action)
------------------------------------------------------------------------
------------------------------------------------------------------------
--  on liste les champs et on donne les valeurs 
INSERT INTO employes 
(id_employes, nom, prenom, sexe, service, date_embauche, salaire) 
VALUES (991, 'Zenzo', 'Ergy', 'm' , 'informatique', CURDATE(), 3500);

-- Raccourci d'écriture : pour lister les colonoes on est obligé de donner autant de valeurs qu'il ya de colones 

INSERT INTO employes VALUES(NULL, 'Mathieu', 'Quittard', 'm', 'informatique', CURDATE(), 3660);

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- REQUETES DE MODIFICATION : UPDATE (action)
------------------------------------------------------------------------
------------------------------------------------------------------------

UPDATE employes
SET service ='web',
salaire = 3300
WHERE id_employes = "992";

SELECT*
FROM employes;


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- REQUETES DE SUPRESSION : DELETE (action)
------------------------------------------------------------------------
------------------------------------------------------------------------

DELETE FROM employes
WHERE id_employes = 338;

DELETE FROM employes
WHERE id_employes > 991;



-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- EXERCICES
------------------------------------------------------------------------
------------------------------------------------------------------------

-- 01 -- Afficher la profession de l'employé 547.
SELECT id_employes, service FROM employes WHERE id_employes = 547;
+-------------+------------+
| id_employes | service    |
+-------------+------------+
|         547 | commercial |
+-------------+------------+
-- 02 -- Afficher la date d'embauche d'Amandine.	
SELECT date_embauche, id_employes, prenom, nom FROM employes WHERE prenom = 'Amandine';	
+---------------+-------------+----------+--------+
| date_embauche | id_employes | prenom   | nom    |
+---------------+-------------+----------+--------+
| 2014-01-23    |         780 | Amandine | Thoyer |
+---------------+-------------+----------+--------+
-- 03 -- Afficher le nom de famille de Guillaume.	
SELECT id_employes, nom, prenom 
FROM employes
WHERE prenom = 'Guillaume';
+-------------+--------+-----------+
| id_employes | nom    | prenom    |
+-------------+--------+-----------+
|         627 | Miller | Guillaume |
+-------------+--------+-----------+
-- 04 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.
SELECT COUNT(*) AS nombre_employes
FROM employes
WHERE id_employes LIKE '%5';
+-----------------+
| nombre_employes |
+-----------------+
|               2 |
+-----------------+		
-- 05 -- Afficher le nombre de commerciaux.	
SELECT COUNT(*)
AS nombre_commerciaux
FROM employes
WHERE service = 'commercial';
+--------------------+
| nombre_commerciaux |
+--------------------+
|                  6 |	
-- 06 -- Afficher le salaire moyen des informaticiens (+arrondie).	
SELECT ROUND(AVG(salaire))
AS  salaire_moyen_informaticiens
FROM employes;	
+------------------------------+
| salaire_moyen_informaticiens |
+------------------------------+
|                         2671 |
+------------------------------+
-- 07 -- Afficher les 5 premiers employés après avoir classer leur nom de famille par ordre alphabétique.	
SELECT id_employes, prenom, nom
FROM employes
ORDER BY nom
LIMIT 5;	
+-------------+---------+----------+
| id_employes | prenom  | nom      |
+-------------+---------+----------+
|         592 | Laura   | Blanchet |
|         854 | Daniel  | Chevel   |
|         547 | Melanie | Collier  |
|         699 | Julien  | Cottet   |
|         739 | Thierry | Desprez  |
+-------------+---------+----------+
-- 08 -- Afficher le coût des commerciaux sur 1 année.	
SELECT (SUM(salaire*12)
AS cout_commercial_annuel
FROM employes
WHERE service = 'commercial';	
+------------------------+
| cout_commercial_annuel |
+------------------------+
|                 184200 |
+------------------------+
-- 09 --* Afficher le salaire moyen par service. (service + salaire moyen)	
SELECT AVG(salaire) AS salaire_par_service, service
FROM employes
GROUP BY service;
+---------------------+---------------+
| salaire_par_service | service       |
+---------------------+---------------+
|           1775.0000 | assistant     |
|           2558.3333 | commercial    |
|           2100.0000 | communication |
|           2900.0000 | comptabilite  |
|           4750.0000 | direction     |
|           2837.5000 | informatique  |
|           3550.0000 | juridique     |
|           2225.0000 | production    |
|           1496.6667 | secretariat   |
|           3300.0000 | web           |
+---------------------+---------------+

-- 10 -- Afficher le nombre de recrutement sur l'année 2015 (+alias).
SELECT COUNT(*) AS employe_2015
FROM employes
WHERE date_embauche 
BETWEEN '2015-01-01' AND '2015-12-31';
+--------------+
| employe_2015 |
+--------------+
|            1 |
+--------------+
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2012 a 2014
SELECT ROUND(AVG(salaire)) AS salaire_moyen_2012_2014
FROM employes
WHERE date_embauche 
BETWEEN '2012-01-01' AND '2014-12-31';
+-------------------------+
| salaire_moyen_2012_2014 |
+-------------------------+
|                    2438 |
+-------------------------+
-- 12 --* Afficher le nombre de service différent.
SELECT COUNT(DISTINCT service) 
AS nombre 
FROM employes ;

+--------+
| nombre |
+--------+
|     10 |
+--------+
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT id_employes, nom, prenom, service
FROM employes
WHERE service NOT IN ('production', 'secretariat');
+-------------+----------+-------------+---------------+
| id_employes | nom      | prenom      | service       |
+-------------+----------+-------------+---------------+
|         350 | Laborde  | Jean-pierre | direction     |
|         388 | Gallet   | Clement     | commercial    |
|         415 | Winter   | Thomas      | commercial    |
|         509 | Grand    | Fabrice     | comptabilite  |
|         547 | Collier  | Melanie     | commercial    |
|         592 | Blanchet | Laura       | direction     |
|         627 | Miller   | Guillaume   | commercial    |
|         655 | Perrin   | Celine      | commercial    |
|         701 | Vignal   | Mathieu     | informatique  |
|         780 | Thoyer   | Amandine    | communication |
|         802 | Durand   | Damien      | informatique  |
|         854 | Chevel   | Daniel      | informatique  |
|         876 | Martin   | Nathalie    | juridique     |
|         933 | Sennard  | Emilie      | commercial    |
|         990 | Lafaye   | Stephanie   | assistant     |
|         991 | Zenzo    | Ergy        | informatique  |
|         992 | Quittard | Mathieu     | web           |
+-------------+----------+-------------+---------------+
-- 14 --* Afficher conjoitement le nombre d'homme et de femme dans l'entreprise

+------+--------+
| sexe | nombre |
+------+--------+
| m    |     11 |
| f    |      9 |
+------+--------+
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2015 de sexe masculin et gagnant un salaire supérieur a 2500 €
SELECT id_employes, nom, prenom, date_embauche, salaire
FROM employes
WHERE sexe = "m" AND date_embauche < '2015-01-01' AND salaire > '2500';
+-------------+---------+-------------+---------------+---------+
| id_employes | nom     | prenom      | date_embauche | salaire |
+-------------+---------+-------------+---------------+---------+
|         350 | Laborde | Jean-pierre | 2010-12-09    |    5000 |
|         415 | Winter  | Thomas      | 2011-05-03    |    3550 |
|         509 | Grand   | Fabrice     | 2011-12-30    |    2900 |
+-------------+---------+-------------+---------------+---------+
-- 16 -- Qui a été embauché en dernier
SELECT * 
FROM employes
ORDER BY date_embauche
DESC LIMIT 1;
+-------------+--------+-------+------+--------------+---------------+---------+
| id_employes | prenom | nom   | sexe | service      | date_embauche | salaire |
+-------------+--------+-------+------+--------------+---------------+---------+
|         991 | Ergy   | Zenzo | m    | informatique | 2022-02-22    |    3500 |
+-------------+--------+-------+------+--------------+---------------+---------+
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT *
FROM employes
WHERE service = 'commercial' 
ORDER BY salaire 
DESC LIMIT 1;
+-------------+--------+--------+------+------------+---------------+---------+
| id_employes | prenom | nom    | sexe | service    | date_embauche | salaire |
+-------------+--------+--------+------+------------+---------------+---------+
|         415 | Thomas | Winter | m    | commercial | 2011-05-03    |    3550 |
+-------------+--------+--------+------+------------+---------------+---------+
-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT prenom, salaire, service
FROM employes 
WHERE service = 'comptabilite'
ORDER BY salaire 
DESC LIMIT 1;
+---------+---------+--------------+
| prenom  | salaire | service      |
+---------+---------+--------------+
| Fabrice |    2900 | comptabilite |
+---------+---------+--------------+
-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier
SELECT prenom 
FROM employes
WHERE service = 'informatique'
ORDER BY date_embauche
ASC LIMIT 1;
+---------+
| prenom  |
+---------+
| Mathieu |
+---------+
-- 20 --* Augmenter chaque employé de 100 €
UPDATE employes
SET salaire = salaire + 100;
-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes
WHERE service = 'secretariat';