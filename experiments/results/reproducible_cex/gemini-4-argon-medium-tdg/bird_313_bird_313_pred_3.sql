-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard counting, filtering out other molecules, NULL molecule_id, NULL element, and unjoined connected/bond records.
INSERT INTO molecule (molecule_id, label) VALUES ('TR004', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR005', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR005_1', 'TR005', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR005_2', 'TR005', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR005_3', 'TR005', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_1', 'TR004', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_1', 'TR006', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('NULL_1', NULL, 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR005_1', 'TR005', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR004_1', 'TR004', '2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR005_1', 'TR005_2', 'B_TR005_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR005_2', 'TR005_1', 'B_TR005_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR005_1', 'TR005_3', 'B_TR005_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.atom_id) FROM atom AS T WHERE T.molecule_id = 'TR005';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM atom WHERE molecule_id = 'TR001';

/*
Prediction Result:
(0,)
*/