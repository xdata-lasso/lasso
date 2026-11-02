-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests DISTINCT requirement when a molecule has multiple '#' bonds and multiple atoms of the same element.
-- Also tests mutants that incorrectly join via the `connected` table instead of `molecule_id`.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M1', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A3', 'M1', 'n');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A4', 'M1', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'M1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'M1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'M1', '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A2', 'A1', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A2', 'A3', 'B3');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A3', 'A2', 'B3');
-- Note: A4 is in M1, not connected to B1 or B2, but should still be returned by the reference query.;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('M1', 'c')
('M1', 'n')
('M1', 'o')
*/

-- Prediction Query
SELECT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Prediction Result:
('M1', 'c')
('M1', 'c')
('M1', 'n')
('M1', 'o')
('M1', 'c')
('M1', 'c')
('M1', 'n')
('M1', 'o')
*/