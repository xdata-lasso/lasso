-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, substring off-by-one errors (index 6 or 8 instead of 7, length 1 or 3), and filtering on atom_id vs atom_id2.
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_45', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_459', 'TR000', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR00045_', 'TR000', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000__45', 'TR000', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_12', 'TR000', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_45_12', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_459_12', 'TR000', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_6_12', 'TR000', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_8_12', 'TR000', '~');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_12_45', 'TR000', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_45', 'TR000_12', 'TR000_45_12');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_459', 'TR000_12', 'TR000_459_12');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR00045_', 'TR000_12', 'TR000_6_12');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000__45', 'TR000_12', 'TR000_8_12');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_12', 'TR000_45', 'TR000_12_45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
('-', 'TR000_45_12')
('=', 'TR000_459_12')
*/

-- Prediction Query
SELECT bond.bond_type, bond.bond_id FROM connected INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE SUBSTRING(connected.atom_id, 7, 2) + 0 = 45 OR SUBSTRING(connected.atom_id2, 7, 2) + 0 = 45;

/*
Prediction Result:
('-', 'TR000_45_12')
('=', 'TR000_459_12')
('-', 'TR000_12_45')
*/