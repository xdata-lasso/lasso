-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01626', 'TR016', 'TR01624');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR01622', 'TR016', 'TR01624');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00223', 'TR016', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('TR00215', 'TR01616', 'TR00221');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01622', 'TR01622', 'TR00215');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR01622', 'TR01626', 'TR00215');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR016', 'TR01622');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR01616', 'TR01622');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('TR01624', None)
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.molecule_id = 'TR002' AND bond.molecule_id = 'TR002';

/*
Prediction Result:
*/