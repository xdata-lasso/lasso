-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'c'), ('te', 'default1'), ('c', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default2', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('te', 'te', 'default2'), ('default1', 'te', 'c'), ('c', 'c', 'default1'), ('default2', 'default2', NULL), ('unique_4', 'default2', NULL), ('unique_5', 'te', 'default1'), ('unique_6', 'default2', 'default2'), ('unique_7', 'default2', 'c');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'default2', NULL), ('unique_4', 'unique_7', 'default1'), ('default2', 'te', NULL), ('default2', 'unique_7', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT "bond"."bond_type" FROM "bond" INNER JOIN "connected" ON "bond"."bond_id" = "connected"."bond_id" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "atom"."element" = 'c';

/*
Prediction Result:
('default1',)
*/