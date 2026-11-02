-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic conditions, OR vs AND mutations, inequality mutations, and DISTINCT requirement.
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B001', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B002', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B003', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B004', 'TR002', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B005', 'TR003', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B006', 'TR004', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A001', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A002', 'TR001', 'h');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A001', 'A002', 'B001');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' AND T1.bond_type = '-';

/*
Gold Result:
('TR001',)
*/

-- Prediction Query
SELECT T2.molecule_id FROM bond AS T1 JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-';

/*
Prediction Result:
('TR001',)
('TR001',)
*/