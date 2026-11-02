-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests: Mutants that enforce T2.bond_id = T3.bond_id. In the reference query, T1 joins T2 on molecule_id and T3 on atom_id, without requiring T3.bond_id = T2.bond_id.
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'f');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_SINGLE', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_DOUBLE', 'M1', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B_SINGLE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '=';

/*
Gold Result:
('cl',)
*/

-- Prediction Query
SELECT DISTINCT a.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE b.bond_type = '=';

/*
Prediction Result:
*/