-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO molecule (molecule_id, label) VALUES ('TR0100', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR05', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR0500', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('tr030', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A_100', 'TR0100', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A_05', 'TR05', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A_500', 'TR0500', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A_lower', 'tr030', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('A_100',)
('A_05',)
*/

-- Prediction Query
SELECT "atom_id" FROM "atom" WHERE "element" = 'c' AND SUBSTRING("molecule_id", 3, 3) >= '010' AND SUBSTRING("molecule_id", 3, 3) <= '050';

/*
Prediction Result:
('A_100',)
('A_05',)
('A_500',)
('A_lower',)
*/