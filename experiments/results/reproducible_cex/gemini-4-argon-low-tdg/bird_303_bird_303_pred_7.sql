-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR006', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR006', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR007', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(CASE WHEN t1.bond_type = '=' THEN 1 ELSE NULL END) AS double_bonds, t2.label FROM bond AS t1 INNER JOIN molecule AS t2 ON t1.molecule_id = t2.molecule_id WHERE t1.molecule_id = 'TR006';

/*
Prediction Result:
(0, '-')
*/