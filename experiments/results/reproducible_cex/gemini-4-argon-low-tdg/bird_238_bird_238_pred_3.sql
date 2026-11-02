-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, DISTINCT vs non-DISTINCT on molecule_id, and filtering on bond_type = '#'.
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.bond_type = '#';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM bond WHERE bond_type = '#';

/*
Prediction Result:
(2,)
*/