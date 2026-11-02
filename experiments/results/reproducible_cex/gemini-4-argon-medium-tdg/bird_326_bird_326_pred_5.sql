-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, DISTINCT requirement (multiple 's' atoms and multiple '=' bonds for the same molecule),
-- and negative cases where only one of the two conditions is met (kills OR vs AND mutations, missing WHERE clauses, and missing DISTINCT).
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '-');
-- TR001: Matches both conditions multiple times (Tests DISTINCT)
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_3', 'TR001', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_2', 'TR001_1_2');
-- TR002: Has element 's', but bond_type is '-' (Tests bond_type = '=' filter)
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_2', 'TR002', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_1', 'TR002_2', 'TR002_1_2');
-- TR003: Has bond_type '=', but element is 'c' (Tests element = 's' filter)
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_1', 'TR003', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_2', 'TR003', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR003_1_2', 'TR003', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR003_1', 'TR003_2', 'TR003_1_2');
-- TR004: Matches neither
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_1', 'TR004', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR004_1_2', 'TR004', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('TR001',)
*/

-- Prediction Query
SELECT T1.label FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T2.atom_id = T3.atom_id INNER JOIN bond AS T4 ON T3.bond_id = T4.bond_id WHERE T2.element = 's' AND T4.bond_type = '=';

/*
Prediction Result:
('+',)
*/