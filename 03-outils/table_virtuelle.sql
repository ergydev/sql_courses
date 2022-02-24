-- table virtuelle : View
-- Une table virtuelle se construit depuis une requetes et des données existantes
-- Les données d'une table virtuelle (vue) sont les mêmes que  les données initiales (si je modifie une donnée sur la vue, les données d'origines sont aussi modifiées et inversement)
-- Durée de vie : jusqu'à ce que le dev la supprime avec un drop
USE bibliotheque;

SHOW TABLES;

CREATE VIEW vue_emprunt AS
    SELECT prenom, date_sortie, date_rendu, titre, auteur 
    FROM abonne a, emprunt e, livre l
    WHERE a.id_abonne = e.id_abonne 
    AND l.id_livre = e.id_livre;

SHOW TABLES;

+------------------------+
| Tables_in_bibliotheque |
+------------------------+
| abonne                 |
| emprunt                |
| livre                  |
| vue_emprunt            |
+------------------------+

SELECT * FROM vue_emprunt;

-- Pour supprimer la vue :
DROP VIEW vue_emprunt;
SHOW TABLES;

+------------------------+
| Tables_in_bibliotheque |
+------------------------+
| abonne                 |
| emprunt                |
| livre                  |
+------------------------+


-- POUR voir les vues présentes sur le serveur
SELECT * FROM information_schema.views;