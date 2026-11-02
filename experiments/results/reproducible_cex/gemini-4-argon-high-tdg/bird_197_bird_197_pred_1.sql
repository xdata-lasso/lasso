-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'O');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm4', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm4', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a12', 'm4', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'm3', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b8', 'm4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b9', 'm4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b10', 'm4', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(2.5,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.element = 'o' THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT T2.molecule_id) AS avg_oxygen_atoms FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-';

/*
Prediction Result:
(1.6666666666666667,)
*/