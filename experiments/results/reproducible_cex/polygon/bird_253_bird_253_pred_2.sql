-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#21', '#33', '#30');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#31', '#33', '#21');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#32', '#33', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#23', NULL, '#21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#21', '#21', '#32');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#21', '#31', '#32');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#22', '#21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#33', '#21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('#30',)
*/

-- Prediction Query
SELECT T3.element FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T1.atom_id = T3.atom_id WHERE T2.bond_type = '#';

/*
Prediction Result:
('#30',)
('#30',)
*/