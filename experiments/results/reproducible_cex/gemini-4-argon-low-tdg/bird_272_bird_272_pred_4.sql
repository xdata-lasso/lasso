-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, DISTINCT enforcement (multiple matching atoms/bonds per molecule), and Connected table disconnect (valid molecule where the 'c' atom is NOT connected to the '#' bond).
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('M1', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A1', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A2', 'M1', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A3', 'M1', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A4', 'M1', 'n');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B1', 'M1', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('B2', 'M1', '#');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('A3', 'A4', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('M1',)
*/

-- Prediction Query
SELECT molecule.molecule_id FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE atom.element = 'c' AND bond.bond_type = '#' AND molecule.label = '-' LIMIT 2;

/*
Prediction Result:
('M1',)
('M1',)
*/