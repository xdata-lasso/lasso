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
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm3', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm3', 'f');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm5', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element <> 'f' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT (COUNT(DISTINCT m."molecule_id") - COUNT(DISTINCT CASE WHEN a."element" = 'f' THEN m."molecule_id" END)) * 100.0 / COUNT(DISTINCT m."molecule_id") AS percentage FROM "molecule" AS m LEFT JOIN "atom" AS a ON m."molecule_id" = a."molecule_id" WHERE m."label" = '+';

/*
Prediction Result:
(50.0,)
*/