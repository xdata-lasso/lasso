-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in molecule_id, orphan molecules (no bonds), and bonds without connected atoms (catches unnecessary JOINs with atom/connected)
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M1', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M2', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M3', NULL);
-- M1 has '=' bond and connected atoms
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'M1', 'o');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'M1', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'B1');
-- M2 has '=' bond, but NO atoms and NO entries in connected (catches unnecessary INNER JOIN with atom or connected)
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'M2', '=');
-- Bond with NULL molecule_id and bond_type '=' (catches INNER JOIN with molecule table, as NULL sorts first in SQLite)
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', NULL, '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', NULL, '=');
-- M3 has no bonds at all (catches queries selecting from molecule without proper filtering);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
(None,)
('M1',)
('M2',)
*/

-- Prediction Query
SELECT DISTINCT m.molecule_id FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '=' ORDER BY m.molecule_id LIMIT 5;

/*
Prediction Result:
('M1',)
('M2',)
*/