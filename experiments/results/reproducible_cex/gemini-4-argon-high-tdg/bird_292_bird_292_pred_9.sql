-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO molecule (molecule_id, label) VALUES ('TR01', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0100', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR040', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0500', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('tr020', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR01_1', 'TR01', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR0100_1', 'TR0100', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR040_1', 'TR040', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR040_2', 'TR040', 'C');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR040_3', 'TR040', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR040_4', 'TR040', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR040_5', 'TR040', 'sc');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR0500_1', 'TR0500', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('tr020_1', 'tr020', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('TR0100_1',)
('TR040_1',)
*/

-- Prediction Query
SELECT atom_id FROM atom WHERE CAST(SUBSTRING(molecule_id, 3) AS INTEGER) BETWEEN 10 AND 50 AND element = 'c';

/*
Prediction Result:
('TR040_1',)
('tr020_1',)
*/