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
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_3', 'TR001', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_4', 'TR001', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_2', 'TR002', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_1', 'TR003', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_2', 'TR003', 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR002', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR003', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_3', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_3', 'TR001_1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_3', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_3', 'TR001_2', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_3', 'TR001_4', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_4', 'TR001_3', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_1', 'TR002_2', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_2', 'TR002_1', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR003_1', 'TR003_2', 'B5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR003_2', 'TR003_1', 'B5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('TR001', 'c')
('TR001', 'n')
('TR001', 'o')
('TR002', 'c')
('TR002', 'h')
*/

-- Prediction Query
SELECT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Prediction Result:
('TR001', 'c')
('TR001', 'c')
('TR001', 'n')
('TR001', 'o')
('TR001', 'c')
('TR001', 'c')
('TR001', 'n')
('TR001', 'o')
('TR002', 'c')
('TR002', 'h')
*/