-- Une table temporaire se construit depuis une requete mais les données sont indépendantes des données initiales (si je modifie une donnée de la table temporaire, la donnée initiale ne sera pas modifiée)
-- Durée de vie très courte, si on ferme la session, la table temporaire sera naturellement supprimée


USE entreprise;

SHOW TABLES;
CREATE TEMPORARY TABLE commerciaux AS SELECT * FROM employes WHERE service = 'commercial';
SHOW TABLES;


SELECT * FROM commerciaux;
+-------------+-----------+---------+------+------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service    | date_embauche | salaire |
+-------------+-----------+---------+------+------------+---------------+---------+
|         388 | Clement   | Gallet  | m    | commercial | 2010-12-15    |    2400 |
|         415 | Thomas    | Winter  | m    | commercial | 2011-05-03    |    3650 |
|         547 | Melanie   | Collier | f    | commercial | 2012-01-08    |    3200 |
|         627 | Guillaume | Miller  | m    | commercial | 2012-07-02    |    2000 |
|         655 | Celine    | Perrin  | f    | commercial | 2012-09-10    |    2800 |
|         933 | Emilie    | Sennard | f    | commercial | 2017-01-11    |    1900 |
+-------------+-----------+---------+------+------------+---------------+---------+

CREATE TEMPORARY TABLE femme AS SELECT nom, prenom, sexe FROM employes WHERE Sexe = 'f';
SELECT * FROM femme;
+----------+-----------+------+
| nom      | prenom    | sexe |
+----------+-----------+------+
| Dubar    | Chloe     | f    |
| Collier  | Melanie   | f    |
| Blanchet | Laura     | f    |
| Perrin   | Celine    | f    |
| Thoyer   | Amandine  | f    |
| Martin   | Nathalie  | f    |
| Sennard  | Emilie    | f    |
| Lafaye   | Stephanie | f    |
+----------+-----------+------+