-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests projection, join condition accuracy, multiple bonds per molecule, NULL labels, and cross-table value overlaps (e.g., label = '#', bond_id = molecule_id).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m1', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m2', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('b1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b1', 'm1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b2', 'm1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('b3', 'm2', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('m1', 'b1', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_id, T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('b1', '+')
('b2', '+')
('b3', None)
*/

-- Prediction Query
SELECT bond.bond_id, molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '#' AND (molecule.label = '+' OR molecule.label = '-');

/*
Prediction Result:
('b1', '+')
('b2', '+')
*/