-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR009', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR008', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR008', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR008', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR009', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR009', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '=' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS T WHERE T.molecule_id = 'TR008';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT ROUND((CAST(SUM(bond_type = '=') AS REAL) * 100.0 / CAST(COUNT(bond_id) AS REAL)), 5) AS percent FROM bond WHERE molecule_id = 'TR008';

/*
Prediction Result:
(33.33333,)
*/