-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a4', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a1', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a2', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a3', 'b3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(0.6666666666666666,)
*/

-- Prediction Query
SELECT AVG(num_bonds) AS average_bonds FROM (SELECT atom_id, COUNT(bond_id) AS num_bonds FROM (SELECT a.atom_id, c.bond_id FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'i') AS iodine_atoms GROUP BY atom_id) AS iodine_bonds_count;

/*
Prediction Result:
(2.0,)
*/