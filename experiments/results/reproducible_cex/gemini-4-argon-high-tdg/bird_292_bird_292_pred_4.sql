-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR009', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR030', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR050', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR051', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR009_1', 'TR009', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR010_1', 'TR010', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR030_1', 'TR030', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR050_1', 'TR050', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR051_1', 'TR051', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('TR010_1',)
('TR030_1',)
('TR050_1',)
*/

-- Prediction Query
SELECT atom_id FROM atom WHERE element = 'c' AND CAST(SUBSTRING(molecule_id, 3, 2) AS INTEGER) >= 10 AND CAST(SUBSTRING(molecule_id, 3, 2) AS INTEGER) <= 50;

/*
Prediction Result:
*/