-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting (DESC vs ASC), WHERE clause filtering ('TR018' vs others), and LIMIT 1.
-- For TR018: '=' has count 2, '-' has count 1.
-- Globally (without WHERE): '-' has count 4, '=' has count 2.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR019', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR018', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'TR018', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'TR018', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'TR019', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B5', 'TR019', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B6', 'TR019', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'TR018', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'TR018', 'c');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('=',)
*/

-- Prediction Query
SELECT T.bond_type, T2.label FROM (SELECT bond_type, COUNT(*) AS bond_count FROM bond WHERE molecule_id = 'TR010' GROUP BY bond_type ORDER BY bond_count DESC, bond_type NULLS LAST LIMIT 1) AS T JOIN molecule AS T2 ON T2.molecule_id = 'TR010';

/*
Prediction Result:
*/