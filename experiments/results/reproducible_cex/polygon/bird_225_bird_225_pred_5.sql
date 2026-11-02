-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=13', NULL, '=18');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=12', '=18', '=18');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=16', '=18', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=17', '=18', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=13', '=12', '=17');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=12', '=12', '=17');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=' ORDER BY T.molecule_id LIMIT 5;

/*
Gold Result:
('=18',)
*/

-- Prediction Query
SELECT DISTINCT molecule.label FROM bond INNER JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '=' ORDER BY molecule.molecule_id ASC, molecule.label NULLS LAST LIMIT 5;

/*
Prediction Result:
(None,)
*/