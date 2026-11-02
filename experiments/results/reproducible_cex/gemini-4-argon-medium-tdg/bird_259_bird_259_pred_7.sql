-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M4', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('M5', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M3', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A7', 'M4', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A8', 'M1', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A9', NULL, 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M3', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'M5', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', NULL, '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B9', 'M4', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A5', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A5', 'A4', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.element) FROM (SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '-') AS T;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT atom.element) AS element_count FROM bond INNER JOIN connected ON bond.bond_id = connected.bond_id INNER JOIN atom ON connected.atom_id = atom.atom_id WHERE bond.bond_type = '-';

/*
Prediction Result:
(2,)
*/