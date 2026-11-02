-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT requirement (multiple 'cl' atoms in the same '+' molecule),
-- AND vs OR conditions, equality vs inequality, and basic foreign key joins.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR001', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR002', '-');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR003', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR004', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_1', 'TR001', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_2', 'TR001', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR001_3', 'TR001', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR002_1', 'TR002', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR003_1', 'TR003', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR003_2', 'TR003', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR004_1', 'TR004', 'o');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('TR001',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'cl' AND T1.label = '+';

/*
Prediction Result:
('TR001',)
('TR001',)
*/