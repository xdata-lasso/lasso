-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'te');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'te');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M2', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A4', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('-',)
('=',)
*/

-- Prediction Query
SELECT DISTINCT "bond"."bond_type" FROM "bond" INNER JOIN "connected" ON "bond"."bond_id" = "connected"."bond_id" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "atom"."element" = 'c';

/*
Prediction Result:
('-',)
*/