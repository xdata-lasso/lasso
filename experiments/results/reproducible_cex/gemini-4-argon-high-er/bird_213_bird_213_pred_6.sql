-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_8', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_20', 'M1', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_8', 'TR004_20', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_20', 'TR004_8', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR004_8' AND T2.atom_id2 = 'TR004_20' OR T2.atom_id2 = 'TR004_8' AND T2.atom_id = 'TR004_20';

/*
Gold Result:
('-',)
('-',)
*/

-- Prediction Query
SELECT DISTINCT bond.bond_type FROM connected INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE (connected.atom_id = 'TR004_8' AND connected.atom_id2 = 'TR004_20') OR (connected.atom_id = 'TR004_20' AND connected.atom_id2 = 'TR004_8');

/*
Prediction Result:
('-',)
*/