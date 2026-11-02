-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic predicate logic (AND vs OR), wrong operators (!=, IS NULL), wrong projection (molecule_id, bond_type, label), and LIMIT 1 / aggregation mutations.
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_3', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_3_4', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_4_5', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_5_6', 'TR001', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_2_3', 'TR002', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR003_1_2', 'TR003', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_1_2', NULL, '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.bond_type = '=';

/*
Gold Result:
('TR001_1_2',)
('TR001_2_3',)
*/

-- Prediction Query
SELECT bond.bond_id FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND bond.bond_type = ' = ';

/*
Prediction Result:
*/