-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'TR005', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'TR005', 'H');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'TR005', 'O');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'TR006', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'TR006', 'N');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'TR008', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A7', 'TR008', 'H');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR005', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR005', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR005', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR005', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR006', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'TR006', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'TR008', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', 'TR008', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A1', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A3', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A2', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A5', 'B5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A5', 'A4', 'B6');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A6', 'A7', 'B7');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A7', 'A6', 'B8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.molecule_id BETWEEN 'TR004' AND 'TR010' AND T.bond_type = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.molecule_id BETWEEN 'TR004' AND 'TR010';

/*
Prediction Result:
(5,)
*/