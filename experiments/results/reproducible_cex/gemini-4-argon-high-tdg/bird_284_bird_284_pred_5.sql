-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m6', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m7', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'te');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1_2', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm2', 'Te');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2_2', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm3', 'TE');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3_2', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm4', 'ste');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4_2', 'm4', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm5', 'tex');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5_2', 'm5', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm6', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6_2', 'm6', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm7', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7_2', 'm7', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm2', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm3', '3');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm4', '4');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm5', '5');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm6', '6');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'm7', '7');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a1_2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a2_2', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a3_2', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a4_2', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a5', 'a5_2', 'b5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a6', 'a6_2', 'b6');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a7', 'a7_2', 'b7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c';

/*
Prediction Result:
('1',)
('2',)
('3',)
('4',)
('5',)
('6',)
('7',)
*/