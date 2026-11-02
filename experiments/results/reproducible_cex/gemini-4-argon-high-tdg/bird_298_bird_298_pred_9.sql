-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a12', 'm3', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'h' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'h';

/*
Prediction Result:
(33.333333333333336,)
*/