-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR02420', 'TR024', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=25', '=23', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=19', 'TR024', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=21', 'TR024', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=25', 'TR02420', '=19');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR02420', '=25', '=19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR024', 'TR024');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=23', 'TR024');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT atom.element FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = '=' AND bond.molecule_id = 'TR024';

/*
Prediction Result:
(None,)
*/