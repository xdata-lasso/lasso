-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests COUNT(molecule_id) vs COUNT(bond_type) when NULL is the most frequent bond_type.
-- For TR018: NULL has 3 rows (COUNT(molecule_id) = 3, COUNT(bond_type) = 0).
-- '#' has 2 rows (COUNT(molecule_id) = 2, COUNT(bond_type) = 2).
-- Expected winner: NULL (since COUNT(molecule_id) is 3 > 2).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', '+');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'TR018', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'TR018', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B5', 'TR018', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.bond_type, T1.label FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR018' GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_type) DESC, T2.bond_type NULLS LAST, T1.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('#', '+')
*/