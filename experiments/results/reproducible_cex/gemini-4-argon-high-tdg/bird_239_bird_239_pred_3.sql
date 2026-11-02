-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR019', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_19', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_190', 'TR000', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR019_01', 'TR019', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('T_19', 'TR000', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_01', 'TR000', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR000', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR000', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR019', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR000', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_19', 'TR000_01', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('T_19', 'TR000_01', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_190', 'TR000_01', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR019_01', 'TR000_01', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.atom_id LIKE 'TR%_19';

/*
Prediction Result:
(1,)
*/