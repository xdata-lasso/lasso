-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_3', 'TR001', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_4', 'TR001', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_3', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_4', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_3', 'TR001_1_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_3', 'TR001_1', 'TR001_1_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_2', 'TR001_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_1', 'TR001_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_4', 'TR001_2_4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_4', 'TR001_2', 'TR001_2_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('TR001', 'c')
('TR001', 'h')
('TR001', 'n')
*/

-- Prediction Query
SELECT T3.label, T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id INNER JOIN bond AS T4 ON T2.bond_id = T4.bond_id WHERE T4.bond_type = '#' GROUP BY T3.label, T1.element;

/*
Prediction Result:
('+', 'c')
('+', 'n')
*/