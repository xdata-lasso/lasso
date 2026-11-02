-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('f11', 'TR151', 'TR15116');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('br10', 'TR151', 'TR15116');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('sn13', 'TR151', 'TR15116');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('br10', 'br10', 'sn13');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('i12', 'TR15116');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR151', 'TR15116');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('TR15116',)
*/

-- Prediction Query
SELECT "element" FROM "atom" WHERE "molecule_id" = 'TR151' AND "element" IN ('cl', 'br', 'f', 'i', 'sn', 'pb', 'te');

/*
Prediction Result:
*/