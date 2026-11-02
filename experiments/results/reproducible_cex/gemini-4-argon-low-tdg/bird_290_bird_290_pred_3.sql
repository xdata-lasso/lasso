-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR151', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR150', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR152', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR151_1', 'TR151', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR151_2', 'TR151', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR151_3', 'TR151', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR150_1', 'TR150', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR152_1', 'TR152', 'cl');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_TR151_1', 'TR151', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR151_1', 'TR151_2', 'B_TR151_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('c',)
('o',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id = 'TR151';

/*
Prediction Result:
('c',)
('c',)
('o',)
*/