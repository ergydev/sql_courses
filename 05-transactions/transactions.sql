-- Les transactions sont diponibles avec le moteur de stockage InnoDB (on peut choisir le moteur lors de la création ou le changer dans phpmyadmin : on va sur la table puis dans l'onglet "opérations" il est possible de le changer)

-- Les transactions nous permettent de créer un environnement de travail que l'on pourra annuler (ctrl + Z) ou valider.

-- Attention, certaines actions ne seront pas liées à la transaction, par exemple : les actions CREATE et/ou DROP et/ou ALTER (modification d'une structure (BDD | TABLE))

USE entreprise;

START TRANSACTION; -- Démarre la zone de mis en tampon

SELECT * FROM employes;

UPDATE employes SET service = 'Web' WHERE service = 'informatique';

SELECT * FROM employes;

DELETE FROM  employes WHERE service = 'commercial';

SELECT * FROM employes;

UPDATE employes SET salaire = salaire + 1000 WHERE service = 'Web';

SELECT * FROM employes;

-- COMMIT; -- valide toutes les actions et FERME la transaction
ROLLBACK; -- annuler toutes les actions et FERME la transaction

SELECT * FROM employes;

----------------------------------------------------------------
----------------------------------------------------------------
-- TRANSACTION AVANCEE ET SAVEPOINT
----------------------------------------------------------------
----------------------------------------------------------------
-- il est possible de placer des points de sauvegarde dans notre transaction afin d'y revenir et na pas tout annuler ou tout valider.

START TRANSACTION;

SELECT * FROM employes;

SAVEPOINT point1; -- un point nommé point1

UPDATE employes SET salaire = salaire + 1000;

SELECT * FROM employes;

SAVEPOINT point2;

DELETE FROM employes WHERE service = 'informatique';

SELECT * FROM employes;

SAVEPOINT point3;

DELETE FROM employes;

SELECT * FROM employes;

SAVEPOINT point4;

ROLLBACK TO point3; -- on annule les actions faites après le point3

SELECT * FROM employes;

ROLLBACK TO point4; -- ERROR 1305 (42000): SAVEPOINT point4 does not exist
-- le point4 n'existe plus car on avait fait un rollback to point3

ROLLBACK TO point1; -- on revient au point1
COMMIT; -- on valide toutes les actions antérieures au point1 et FERME la transaction

SELECT * FROM employes;

-- S'il y a un souci, la session est fermée alors qu'une transaction est ouverte, la BDD applique un ROLLBACK par défaut.
