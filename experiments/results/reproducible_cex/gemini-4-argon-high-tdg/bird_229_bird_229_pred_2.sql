-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_2', 'TR000', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_3', 'TR000', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_2', 'TR002', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_1_2', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_2_3', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_1_3', 'TR000', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '~');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1', 'TR000_2', 'TR000_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_1', 'TR000_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_3', 'TR000_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_3', 'TR000_2', 'TR000_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1', 'TR000_3', 'TR000_1_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_3', 'TR000_1', 'TR000_1_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_2', 'TR001_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_1', 'TR001_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_1', 'TR002_2', 'TR002_1_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.bond_type FROM bond AS T WHERE T.molecule_id = 'TR000';

/*
Gold Result:
('-',)
('=',)
*/

-- Prediction Query
SELECT "bond_type" FROM "bond" WHERE "molecule_id" = 'TR000';

/*
Prediction Result:
('-',)
('-',)
('=',)
*/