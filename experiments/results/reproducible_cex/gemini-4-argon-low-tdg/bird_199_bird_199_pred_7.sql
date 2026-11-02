-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, DISTINCT requirement (multiple 'na' atoms in the same molecule), and non-matching conditions (wrong element, wrong label, NULL values).
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M4', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'na');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'na');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M2', 'na');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M4', 'na');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A7', NULL, 'na');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '-' AND T2.element = 'na';

/*
Prediction Result:
(2,)
*/