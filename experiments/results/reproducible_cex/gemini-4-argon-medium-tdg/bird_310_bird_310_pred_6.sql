-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, DISTINCT molecule counting across multiple '=' bonds,
-- filtering out non-'=' bonds, and SUM(CASE...) with '+', '-', and NULL labels.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m1', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m2', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m3', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m4', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m5', '+');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b1', 'm1', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b2', 'm1', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b3', 'm1', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b4', 'm2', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b5', 'm3', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b6', 'm4', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id), SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=';

/*
Gold Result:
(3, 2)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.molecule_id) AS total_double_bonds, COUNT(DISTINCT CASE WHEN m.label = '+' THEN b.molecule_id END) AS carcinogenic_double_bonds FROM bond AS b INNER JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '=';

/*
Prediction Result:
(3, 1)
*/