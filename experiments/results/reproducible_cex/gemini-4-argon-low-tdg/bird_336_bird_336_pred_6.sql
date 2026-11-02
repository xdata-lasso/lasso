-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT in COUNT(DISTINCT T1.molecule_id) (M1 has two '#' bonds).
-- 2. Wrong COUNT column such as COUNT(DISTINCT T1.label) or COUNT(DISTINCT T2.bond_type) (M1 and M2 both qualify, so distinct molecule count is 2, whereas distinct label/bond_type count is 1).
-- 3. Unnecessary joins with 'atom' or 'connected' tables (M2 has no atoms or connected records).
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M2', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'N');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '#' AND T1.label = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.molecule_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type LIKE '#' AND T2.label LIKE '-';

/*
Prediction Result:
(3,)
*/