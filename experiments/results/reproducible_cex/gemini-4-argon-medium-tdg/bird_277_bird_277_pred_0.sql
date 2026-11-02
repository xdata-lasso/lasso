-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', NULL, 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'TR005', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'TR005', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'TR005', 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR005_16_26', NULL, NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('tr005_16_26', 'TR005', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR005_16_26 ', 'TR005', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'TR005_16_26');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A3', 'TR005_16_26');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A4', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A1', 'tr005_16_26');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A2', 'TR005_16_26 ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('cl',)
(None,)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26' AND T1.element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
('cl',)
*/