-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR006', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR005', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'TR003', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B7', 'TR004', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B8', 'TR007', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B9', 'TR003', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('TR002',)
('TR003',)
('TR004',)
('TR005',)
('TR006',)
*/

-- Prediction Query
SELECT T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' ORDER BY T2.label, T1.bond_id NULLS LAST, T2.molecule_id NULLS LAST LIMIT 5;

/*
Prediction Result:
('+',)
('+',)
('+',)
('-',)
('-',)
*/