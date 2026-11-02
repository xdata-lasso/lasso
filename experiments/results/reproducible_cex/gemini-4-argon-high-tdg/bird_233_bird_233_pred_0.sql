-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A0', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'TR006', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'TR006', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'TR006', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'TR006', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B0', 'TR001', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR006', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR006', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR006', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A0', 'A1', 'B0');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A4', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A3', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
('B1',)
('B2',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006' ORDER BY T1.bond_type ASC, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 2;

/*
Prediction Result:
('1',)
('1',)
*/