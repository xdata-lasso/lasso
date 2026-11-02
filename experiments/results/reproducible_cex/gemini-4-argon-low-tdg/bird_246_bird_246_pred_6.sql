-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, substring boundary/offset errors, LIKE '%45%' vs SUBSTRING, and atom_id vs atom_id2 confusion.
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_45', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_10', 'TR001', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR045_10', 'TR001', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_145', 'TR001', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_450', 'TR001', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_MATCH_EXACT', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_MATCH_LONG', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_WRONG_POS_EARLY', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_WRONG_POS_LATE', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_WRONG_COL_ATOM2', 'TR001', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_45', 'TR001_10', 'B_MATCH_EXACT');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_450', 'TR001_10', 'B_MATCH_LONG');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR045_10', 'TR001_10', 'B_WRONG_POS_EARLY');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_145', 'TR001_10', 'B_WRONG_POS_LATE');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_10', 'TR001_45', 'B_WRONG_COL_ATOM2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
('-', 'B_MATCH_EXACT')
('=', 'B_MATCH_LONG')
*/

-- Prediction Query
SELECT bond.bond_type, bond.bond_id FROM connected INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE SUBSTRING(connected.atom_id, 7, 2) + 0 = 45 OR SUBSTRING(connected.atom_id2, 7, 2) + 0 = 45;

/*
Prediction Result:
('-', 'B_MATCH_EXACT')
('=', 'B_MATCH_LONG')
('=', 'B_WRONG_COL_ATOM2')
*/