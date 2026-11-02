-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. INNER JOIN with atom (M1 has no atoms -> excluded, kills mutants missing atom join or using LEFT JOIN).
-- 2. WHERE bond_type = '#' vs other bond types (M4 only has '=' -> excluded; M2 has both '#' and '-' -> included).
-- 3. COUNT(DISTINCT) vs COUNT() when molecules have unequal numbers of atoms and '#' bonds (M2 has 3 atoms, 2 '#' bonds = 6 rows; M3 has 1 atom, 1 '#' bond = 1 row. Distinct ratio is 1/2 = 50.0, non-distinct is 6/7 = 85.71).
-- 4. CAST(... AS REAL) * 100 / ... vs integer division before * 100.
-- 5. NULL label handling (M5 has NULL label).
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M4', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M5', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M4', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M5', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M3', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M4', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'M5', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T2.label = '+' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.bond_type = '#' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.bond_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Prediction Result:
(60.0,)
*/