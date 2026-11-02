-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, filtering out non-'#' bond types, and molecules without bonds or atoms.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR002', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR003', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_2', 'TR001', 'n');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR002_1', 'TR002', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR003_1', 'TR003', 'h');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR001', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'TR002', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'TR002', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'TR004', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('TR001', 'c')
('TR001', 'n')
*/

-- Prediction Query
SELECT b.molecule_id, GROUP_CONCAT(DISTINCT a.element) AS elements FROM bond AS b INNER JOIN atom AS a ON b.molecule_id = a.molecule_id WHERE b.bond_type = '#' GROUP BY b.molecule_id;

/*
Prediction Result:
('TR001', 'c,n')
*/