-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO molecule (molecule_id, label) VALUES ('TR0', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0/5', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0:5', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0999', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR05', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0050', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('tr010', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.molecule_id) FROM molecule AS T WHERE molecule_id BETWEEN 'TR000' AND 'TR099' AND T.label = '+';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM molecule WHERE CAST(SUBSTRING(molecule_id, 3) AS INTEGER) BETWEEN 0 AND 99 AND label = '+';

/*
Prediction Result:
(6,)
*/