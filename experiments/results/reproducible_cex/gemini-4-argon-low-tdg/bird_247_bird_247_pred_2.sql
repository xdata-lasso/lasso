-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Element level exclusion vs Atom level exclusion (C has one connected atom and one disconnected atom; C should be excluded).
-- 2. Join condition on atom_id vs atom_id2 (O only appears in atom_id2 of connected; O should NOT be excluded).
-- 3. Disconnected elements with multiple atoms (H appears twice, never in connected.atom_id; H should be returned once due to DISTINCT).
-- 4. Referential integrity with molecule and bond tables.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m1', '+');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b1', 'm1', '1');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a1', 'm1', 'C');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a2', 'm1', 'C');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a3', 'm1', 'H');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a4', 'm1', 'H');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a5', 'm1', 'O');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('a1', 'a5', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE NOT T.element IN (SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id);

/*
Gold Result:
('H',)
('O',)
*/

-- Prediction Query
SELECT DISTINCT T1.element FROM atom AS T1 LEFT JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.atom_id IS NULL AND T1.element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
*/