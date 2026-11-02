-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR123', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR124', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR125', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR124_1', 'TR124', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR124_2', 'TR124', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR124_1', 'TR124', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR124_2', 'TR124', '2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR124_1', 'TR124_2', 'B_TR124_1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR124_2', 'TR124_1', 'B_TR124_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.label FROM molecule AS T WHERE T.molecule_id = 'TR124';

/*
Gold Result:
('+',)
*/

-- Prediction Query
SELECT CASE WHEN label = '+' THEN 'Yes' ELSE 'No' END FROM molecule WHERE molecule_id = 'TR124';

/*
Prediction Result:
('Yes',)
*/