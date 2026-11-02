-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_3', 'TR001', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_4', 'TR001', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_1', 'TR002', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_2', 'TR002', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_1', 'TR003', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', NULL, 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('TR001_1',)
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'C' AND T2.label = '-';

/*
Prediction Result:
('TR001_3',)
*/