-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_3', 'TR001', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_1', 'TR003', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_3', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_3', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR003_1_2', 'TR003', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_2', 'TR001_1_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('TR001',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN atom AS T3 ON T1.molecule_id = T3.molecule_id WHERE T2.bond_type = '#' AND T3.element = 'c' AND T1.label = '-' LIMIT 2;

/*
Prediction Result:
('TR001',)
('TR001',)
*/