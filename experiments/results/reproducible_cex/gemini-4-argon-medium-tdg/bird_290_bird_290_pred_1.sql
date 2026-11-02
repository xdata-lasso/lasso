-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in element and molecule_id, case sensitivity, substring matching ('TR1510', 'tr151'), and confusion between molecule_id and atom_id/label.
INSERT INTO molecule (molecule_id, label) VALUES ('TR151', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR1510', 'TR151');
INSERT INTO molecule (molecule_id, label) VALUES ('tr151', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'TR151', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'TR151', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', NULL, 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR151', 'TR1510', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'tr151', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('n',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT element FROM atom WHERE molecule_id = 'TR151' AND element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
('n',)
*/