-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, WHERE filtering on molecule_id, GROUP BY on both atom_id and bond_type, and COUNT(DISTINCT bond_type) vs COUNT(*).
-- Also tests mutants that unnecessarily join the 'connected' table (bonds here are in the same molecule, not necessarily connected to every atom).
INSERT INTO molecule (molecule_id, label) VALUES ('TR346', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR346_1', 'TR346', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR346_2', 'TR346', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR346', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR346', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR346', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR000', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR346_1', 'TR346_2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR346_2', 'TR346_1', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('TR346_1', 1)
('TR346_1', 1)
('TR346_2', 1)
('TR346_2', 1)
*/

-- Prediction Query
SELECT T1.atom_id, COUNT(DISTINCT T3.bond_type) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id;

/*
Prediction Result:
('TR346_1', 1)
('TR346_2', 1)
*/