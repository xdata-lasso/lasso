-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('M4', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M2', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M3', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', NULL, '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', NULL, '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_id, T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('B1', '+')
('B2', '+')
('B6', None)
*/

-- Prediction Query
SELECT bond.bond_id, molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '#' AND (molecule.label = '+' OR molecule.label = '-');

/*
Prediction Result:
('B1', '+')
('B2', '+')
*/