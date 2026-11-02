-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR047', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR048', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR047_1', 'TR047', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR047_2', 'TR047', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR047_3', 'TR047', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR048_1', 'TR048', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR048_2', 'TR048', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR047_1_2', 'TR047', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR047_2_3', 'TR047', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR047_1_3', 'TR047', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR048_1_2', 'TR048', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR048_2_1', 'TR048', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_NULL_MOL', NULL, '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR047_1', 'TR047_2', 'TR047_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR047_2', 'TR047_1', 'TR047_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR048_1', 'TR048_2', 'TR048_1_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '=' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS T WHERE T.molecule_id = 'TR047';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.bond_type = ' = ' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T2.bond_id) FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR047';

/*
Prediction Result:
(0.0,)
*/