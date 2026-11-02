-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_20', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002_21', 'TR002', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR003_22', 'TR003', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_23', 'TR004', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR005_24', 'TR005', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_25', 'TR006', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR007_26', 'TR007', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('TR002',)
('TR003',)
('TR004',)
('TR005',)
('TR006',)
*/

-- Prediction Query
SELECT DISTINCT T2.molecule_id, T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, 7, 2) BETWEEN 21 AND 25 AND T2.label = '+';

/*
Prediction Result:
*/