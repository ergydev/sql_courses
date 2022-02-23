-- UNION permet de fusionner 2 requetes en un seul résultat.
-- Pour que UNION  fonctionne, il doit y avoir le même nombre de colonne dans les deux requetes.

-- Affichage des abonnes et des auteurs (liste des personnes physique) de la bibliotheque

USE bibliotheque;

SELECT prenom AS liste FROM abonne 
UNION
SELECT auteur FROM livre;

+-------------------+
| liste             |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Mathieu           |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
+-------------------+

-- UNION applique un distinct par defaut
-- Sinon on peut utiliser UNION ALL

SELECT prenom AS liste FROM abonne 
UNION ALL
SELECT auteur FROM livre;

+-------------------+
| liste             |
+-------------------+
| Guillaume         |
| Benoit            |
| Chloe             |
| Laura             |
| Mathieu           |
| GUY DE MAUPASSANT |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
| ALEXANDRE DUMAS   |
+-------------------+

-- LOWER() pour passer une chaine en minuscule
-- UPPER() pour passer une chaine en majuscule
SELECT UPPER(prenom) AS liste FROM abonne 
UNION ALL
SELECT auteur FROM livre;
+-------------------+
| liste             |
+-------------------+
| GUILLAUME         |
| BENOIT            |
| CHLOE             |
| LAURA             |
| MATHIEU           |
| GUY DE MAUPASSANT |
| GUY DE MAUPASSANT |
| HONORE DE BALZAC  |
| ALPHONSE DAUDET   |
| ALEXANDRE DUMAS   |
| ALEXANDRE DUMAS   |
+-------------------+

-- La liste de tous les livres, de tous les abonnés puis la relation si elle existe.
SELECT auteur, titre, emprunt.id_abonne, prenom
FROM livre 
LEFT JOIN emprunt USING (id_livre) 
LEFT JOIN abonne USING (id_abonne)
UNION
SELECT auteur, titre, emprunt.id_abonne, prenom
FROM livre 
RIGHT JOIN emprunt USING (id_livre) 
RIGHT JOIN abonne USING (id_abonne);
+-------------------+-------------------------+-----------+-----------+
| auteur            | titre                   | id_abonne | prenom    |
+-------------------+-------------------------+-----------+-----------+
| GUY DE MAUPASSANT | Une vie                 |         1 | Guillaume |
| GUY DE MAUPASSANT | Bel-Ami                 |         2 | Benoit    |
| GUY DE MAUPASSANT | Une vie                 |         3 | Chloe     |
| ALPHONSE DAUDET   | Le Petit chose          |         4 | Laura     |
| ALEXANDRE DUMAS   | La Reine Margot         |         1 | Guillaume |
| ALEXANDRE DUMAS   | Les Trois Mousquetaires |         2 | Benoit    |
| ALEXANDRE DUMAS   | Les Trois Mousquetaires |         3 | Chloe     |
| GUY DE MAUPASSANT | Une vie                 |         2 | Benoit    |
| HONORE DE BALZAC  | Le père Goriot          |      NULL | NULL      |
| NULL              | NULL                    |      NULL | Mathieu   |
+-------------------+-------------------------+-----------+-----------+