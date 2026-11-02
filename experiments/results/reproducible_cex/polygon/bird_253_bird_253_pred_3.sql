-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#22', '#32', '#31');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('#21', '#23', '#31');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#33', '#32', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#24', NULL, '#33');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#21', '#22', '#33');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('#22', '#21', '#33');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#32', '#33');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#23', '#33');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('#31',)
*/

-- Prediction Query
SELECT a.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('#31',)
('#31',)
*/