-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting, WHERE filtering (excluding 'TR019'), ORDER BY COUNT DESC, and LIMIT 1.
-- Also includes disconnected atoms/connections to catch extraneous inner joins with atom or connected tables.
INSERT INTO molecule (molecule_id, label) VALUES ('TR018', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR019', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'TR018', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'TR018', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'TR018', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'TR019', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'TR019', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'TR019', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('-',)
*/

-- Prediction Query
SELECT b.bond_type, m.label FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.molecule_id = 'TR010' GROUP BY b.bond_type ORDER BY COUNT(b.bond_type) DESC, b.bond_type NULLS LAST, m.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/