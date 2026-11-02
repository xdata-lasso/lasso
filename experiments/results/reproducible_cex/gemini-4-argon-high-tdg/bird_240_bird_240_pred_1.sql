-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_1', 'TR004', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_2', 'TR004', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_3', 'TR004', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_4', 'TR004', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR005_1', 'TR005', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR004_1_2', 'TR004', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR004_1_3', 'TR004', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR005_1_1', 'TR005', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_1', 'TR004_2', 'TR004_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_1', 'TR004_3', 'TR004_1_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR004';

/*
Gold Result:
('c',)
('h',)
('o',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR004';

/*
Prediction Result:
('c',)
('c',)
('h',)
('o',)
*/