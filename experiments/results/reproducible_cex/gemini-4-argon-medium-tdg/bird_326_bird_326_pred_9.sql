-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests indirect relationship within the same molecule: The 's' atom and the '=' bond belong to the same molecule,
-- but the 's' atom is NOT the atom connected by the '=' bond.
-- Kills mutants that unnecessarily join through the `connected` table requiring the 's' atom itself to have the '=' bond.
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR010_1', 'TR010', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR010_2', 'TR010', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR010_3', 'TR010', 'o');
-- Bond 1 is single bond '-' connected to the 's' atom
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR010_1_2', 'TR010', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR010_1', 'TR010_2', 'TR010_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR010_2', 'TR010_1', 'TR010_1_2');
-- Bond 2 is double bond '=' connected only between 'c' and 'o'
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR010_2_3', 'TR010', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR010_2', 'TR010_3', 'TR010_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR010_3', 'TR010_2', 'TR010_2_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('TR010',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 's' AND T3.bond_type = '=';

/*
Prediction Result:
*/