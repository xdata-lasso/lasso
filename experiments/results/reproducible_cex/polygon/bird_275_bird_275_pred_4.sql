-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=12', '=13', '=19');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=11', '=13', '=19');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=15', '=19', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=14', '=19', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('=11', '=11', '=14');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=19', '=19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=13', '=19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=';

/*
Gold Result:
('=19',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM bond AS T1 WHERE T1.bond_type = '=';

/*
Prediction Result:
('=19',)
('=19',)
*/