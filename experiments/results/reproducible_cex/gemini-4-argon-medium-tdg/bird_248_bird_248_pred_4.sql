-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match and filtering out non-matching bond_type and molecule_id (kills OR vs AND, = vs !=, missing WHERE clauses).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR447', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR448', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'TR447', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'TR447', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A3', 'TR447', 'o');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A4', 'TR448', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A5', 'TR448', 'n');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'TR447', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'TR447', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B3', 'TR448', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B4', 'TR448', '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A1', 'A2', 'B1');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A2', 'A3', 'B2');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A4', 'A5', 'B3');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A5', 'A4', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('A1', 'A2')
*/

-- Prediction Query
SELECT DISTINCT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id INNER JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id INNER JOIN bond AS T4 ON T1.bond_id = T4.bond_id WHERE T2.molecule_id = 'TR041' AND T3.molecule_id = 'TR041' AND T4.bond_type = '#';

/*
Prediction Result:
*/