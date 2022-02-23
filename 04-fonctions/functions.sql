-- FONCTIONS PREDEFINIES (déjà inscrite au langage, le developpeur ne fait que l'exécuter.)
-- En SQL, pas d'espace entre le nom de la fonction et ses parenthèses

SELECT DATABASE(); -- quelle BDD est actuellement utilisée

SELECT CURDATE(); -- date YYYY-MM-DD
SELECT NOW(); -- date et heure YYYY-MM-DD HH:II:SS


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
