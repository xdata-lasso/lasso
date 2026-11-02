-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_3', 'TR001', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_3_4', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_1_2', 'TR002', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002_2_3', 'TR002', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR003_1_2', 'TR003', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=';

/*
Gold Result:
('TR001',)
('TR003',)
*/

-- Prediction Query
SELECT molecule_id FROM bond WHERE bond_type = ' = ';

/*
Prediction Result:
*/