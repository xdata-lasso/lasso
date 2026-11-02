-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, WHERE condition filtering (including '=', '#', NULL, and whitespace variations),
-- 1-to-many bond-to-connected relationships, and unconnected bonds (catches LEFT JOIN vs INNER JOIN).
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'H');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'O');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M1', 'N');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M1', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M1', ' - ');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A3', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A4', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A4', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B6');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Gold Result:
('B1', 'A1', 'A2')
('B1', 'A2', 'A1')
*/

-- Prediction Query
SELECT T1.bond_type, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Prediction Result:
('-', 'A1', 'A2')
('-', 'A2', 'A1')
*/