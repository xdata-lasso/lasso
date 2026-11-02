-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching with multiple matching bonds, non-matching bond types, and other molecules with the same label.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR007', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR008', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR006', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'TR006', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'TR006', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'TR006', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B5', 'TR007', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B6', 'TR008', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B7', NULL, '=');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'TR006', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'TR006', 'o');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A2', 'A1', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(2, '+')
*/

-- Prediction Query
SELECT COUNT(CASE WHEN T1.bond_type = 'double' THEN 1 END) AS double_bond_count, T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Prediction Result:
(0, '+')
*/