-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('m_indirect', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a_s', 'm_indirect', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a_c1', 'm_indirect', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a_c2', 'm_indirect', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b_single', 'm_indirect', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b_double', 'm_indirect', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a_s', 'a_c1', 'b_single');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a_c1', 'a_c2', 'b_double');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('m_indirect',)
*/

-- Prediction Query
SELECT T3.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '=' AND T3.element = 's';

/*
Prediction Result:
*/