-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1_1', 'm1', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1_2', 'm1', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1_3', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2_1', 'm2', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2_2', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3_1', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3_2', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4_1', 'm4', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1_1', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1_2', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1_3', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2_1', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2_2', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3_1', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4_1', 'm4', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1_1', 'a1_2', 'b1_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1_2', 'a1_3', 'b1_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('m1',)
*/

-- Prediction Query
SELECT T1.label FROM molecule AS T1 JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T2.element = 's' AND T3.bond_type = '=';

/*
Prediction Result:
('+',)
('+',)
('+',)
('+',)
*/