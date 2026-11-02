-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests asymmetric 'connected' graph (T1.atom_id = T2.atom_id vs T1.atom_id = T2.atom_id2), DISTINCT on duplicate elements, and WHERE filter on bond_id.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_2', 'TR001', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_4', 'TR001', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_5', 'TR001', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_6', 'TR001', 'n');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_2_4', 'TR001', '1');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR001_5_6', 'TR001', '2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_2', 'TR001_4', 'TR001_2_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_5', 'TR001_4', 'TR001_2_4');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR001_6', 'TR001_2', 'TR001_5_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('c',)
*/

-- Prediction Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('c',)
('c',)
*/