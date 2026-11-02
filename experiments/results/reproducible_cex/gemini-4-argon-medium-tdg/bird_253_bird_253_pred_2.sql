-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT keyword (duplicate 'c' elements connected to '#' bonds)
-- 2. WHERE clause filtering (bond_type '#' vs '-' vs '=' vs NULL)
-- 3. JOIN condition on connected: T2.atom_id vs T2.atom_id2 (asymmetric connections where atom_id has 'c' and atom_id2 has 'n')
-- 4. Unconnected atoms and bonds (LEFT/RIGHT JOIN mutants)
-- 5. Incorrect join paths (e.g., joining atom and bond via molecule_id instead of connected table)
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M2', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M1', 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M2', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M2', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A3', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A1', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A5', 'A1', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A5', 'A2', 'B5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('c',)
*/

-- Prediction Query
SELECT DISTINCT "atom"."element" FROM "atom" INNER JOIN "connected" ON "atom"."atom_id" = "connected"."atom_id" OR "atom"."atom_id" = "connected"."atom_id2" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" WHERE "bond"."bond_type" = '#';

/*
Prediction Result:
('c',)
('n',)
*/