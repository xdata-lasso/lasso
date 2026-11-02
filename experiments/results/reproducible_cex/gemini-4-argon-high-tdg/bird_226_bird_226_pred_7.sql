-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR008_1', 'TR008', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR008_2', 'TR008', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR008_3', 'TR008', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', 'TR001', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR008', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR008', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR008', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR001', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR008_1', 'TR008_2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR008_2', 'TR008_1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR008_2', 'TR008_3', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_1', 'TR001_2', 'B4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '=' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS T WHERE T.molecule_id = 'TR008';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT ROUND(SUM(IIF(bond.bond_type = '=', 1, 0)) * 100.0 / COUNT(bond.bond_id), 5) AS percentage FROM bond WHERE bond.molecule_id = 'TR008';

/*
Prediction Result:
(66.66667,)
*/