-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR012', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR014', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_2', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_2', 'TR002', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_3', 'TR002', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B001', 'TR014', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B002', 'TR012', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B003', 'TR010', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B004', 'TR008', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B005', 'TR006', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B006', 'TR004', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B007', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B008', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B009', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B010', 'TR000', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B011', 'TR001', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B012', 'TR003', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1', 'TR000_2', 'B010');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_1', 'TR002_2', 'B007');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_2', 'TR002_1', 'B007');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR002_2', 'TR002_3', 'B008');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('TR002',)
('TR004',)
('TR006',)
('TR008',)
('TR010',)
*/

-- Prediction Query
SELECT molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = ' = ' ORDER BY molecule.label, bond.bond_id NULLS LAST, molecule.molecule_id NULLS LAST LIMIT 5;

/*
Prediction Result:
*/