-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate pairs of element and bond_type in TR016)
-- 2. Missing WHERE clause or wrong comparison operator (data in TR015, TR017)
-- 3. Missing JOIN condition (Cartesian product across molecules)
-- 4. Incorrect join via the 'connected' table (c2 and b2 are in TR016, but not in 'connected')
INSERT INTO molecule (molecule_id, label) VALUES ('TR015', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR016', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR017', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'TR016', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'TR016', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'TR016', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'TR015', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'TR017', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'TR016', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'TR016', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'TR016', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'TR015', '3');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'TR017', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('c', '1')
('c', '2')
('h', '1')
('h', '2')
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.molecule_id = 'TR002';

/*
Prediction Result:
*/