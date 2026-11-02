-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_1', 'TR004', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_2', 'TR004', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_3', 'TR004', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR004_1', 'TR004', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR001_1', 'TR001', '2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_1', 'TR004_2', 'B_TR004_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_2', 'TR004_1', 'B_TR004_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR004';

/*
Gold Result:
('c',)
('h',)
*/

-- Prediction Query
SELECT T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR004';

/*
Prediction Result:
('c',)
('c',)
('h',)
*/