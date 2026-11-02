-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR012', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR013', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR012_1', 'TR012', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR012_2', 'TR012', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR012_3', 'TR012', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR013_1', 'TR013', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR012_1_2', 'TR012', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR012_2_3', 'TR012', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR013_1_2', 'TR013', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR012_1', 'TR012_2', 'TR012_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR012_2', 'TR012_1', 'TR012_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR012_2', 'TR012_3', 'TR012_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR012_3', 'TR012_2', 'TR012_2_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('TR012_1',)
*/

-- Prediction Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id JOIN connected AS T3 ON T1.atom_id = T3.atom_id OR T1.atom_id = T3.atom_id2 JOIN bond AS T4 ON T3.bond_id = T4.bond_id WHERE T2.molecule_id = 'TR012' AND T1.element = 'c' AND T4.bond_type = '=';

/*
Prediction Result:
*/