-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M4', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('M5', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'H');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M2', 'O');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M2', 'H');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M2', 'H');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M3', 'N');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A7', 'M4', 'C');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M2', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M3', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'M4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', 'M5', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(3.5,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.bond_type = '-' THEN 1 ELSE 0 END) AS REAL) / COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+';

/*
Prediction Result:
(0.6666666666666666,)
*/