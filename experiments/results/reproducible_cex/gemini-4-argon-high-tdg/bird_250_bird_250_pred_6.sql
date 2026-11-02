-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm3', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b9', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm3', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b9');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a4', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a5', 'a6', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a6', 'a5', 'b5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) FROM bond AS T1 INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.label = '+' AND T1.bond_type = '=' GROUP BY T3.molecule_id ORDER BY COUNT(T1.bond_type) DESC, T3.molecule_id NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('m2',)
*/

-- Prediction Query
SELECT m.label FROM molecule AS m INNER JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE m.label = '+' AND b.bond_type = ' = ' GROUP BY m.label ORDER BY COUNT(b.bond_id) DESC, m.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/