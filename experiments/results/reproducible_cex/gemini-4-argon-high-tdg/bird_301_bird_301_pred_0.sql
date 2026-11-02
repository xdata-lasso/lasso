-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007_4_19', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR007_4', 'TR007', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR007_19', 'TR007', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR007_1', 'TR007', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR007_4_19', 'TR007', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR007_1_4', 'TR007', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_SWAP_MOL', 'TR007_4_19', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_SWAP_TYPE', 'TR007', 'TR007_4_19');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR007_4', 'TR007_19', 'TR007_4_19');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR007_19', 'TR007_4', 'TR007_4_19');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR007_1', 'TR007_4', 'TR007_1_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM bond AS T WHERE T.bond_id = 'TR007_4_19';

/*
Gold Result:
('-',)
*/

-- Prediction Query
SELECT T2.bond_type FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T1.atom_id = 'TR007_4_19' OR T1.atom_id2 = 'TR007_4_19';

/*
Prediction Result:
*/