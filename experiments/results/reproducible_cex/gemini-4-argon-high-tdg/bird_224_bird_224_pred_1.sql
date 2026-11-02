-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1', 'TR000', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_2', 'TR000', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_3', 'TR000', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_1_2', 'TR000', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_2_3', 'TR000', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_3_1', 'TR000', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1', 'TR000_2', 'TR000_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_3', 'TR000_2_3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_3', 'TR000_1', 'TR000_3_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_id FROM connected AS T WHERE T.atom_id2 = 'TR000_2';

/*
Gold Result:
('TR000_1_2',)
*/

-- Prediction Query
SELECT bond_id FROM connected WHERE atom_id2 = (SELECT atom_id2 FROM connected WHERE atom_id = 'TR000_2');

/*
Prediction Result:
('TR000_2_3',)
*/