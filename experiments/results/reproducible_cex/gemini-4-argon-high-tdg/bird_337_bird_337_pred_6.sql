-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR016', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR017', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR016_1', 'TR016', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR016_2', 'TR016', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR016_3', 'TR016', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR016_4', 'TR016', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR017_1', 'TR017', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR017_2', 'TR017', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR016_1', 'TR016', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR016_2', 'TR016', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR016_3', 'TR016', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR017_1', 'TR017', '3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR016_1', 'TR016_2', 'B_TR016_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR016_2', 'TR016_1', 'B_TR016_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR016_3', 'TR016_4', 'B_TR016_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR016_4', 'TR016_3', 'B_TR016_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR017_1', 'TR017_2', 'B_TR017_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR017_2', 'TR017_1', 'B_TR017_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('c', '1')
('c', '2')
('h', '1')
('h', '2')
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.molecule_id = 'TR002' AND bond.molecule_id = 'TR002';

/*
Prediction Result:
*/