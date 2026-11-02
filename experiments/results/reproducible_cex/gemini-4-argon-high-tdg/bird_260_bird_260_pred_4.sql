-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm2', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.atom_id) FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE b.bond_type = '#' AND a.element IN ('p', 'br');

/*
Prediction Result:
(3,)
*/