-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('p', 'br'), ('#', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('br', 'p', 'default1'), ('#', NULL, '#'), ('default2', NULL, 'default1'), ('default1', '#', 'p'), ('p', 'p', 'br'), ('unique_5', 'p', 'default2'), ('unique_6', '#', 'default1'), ('unique_7', NULL, 'br'), ('unique_8', '#', 'p'), ('unique_9', 'p', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('#', 'p', 'default2'), ('br', 'p', 'br'), ('default1', '#', NULL), ('default2', '#', 'br'), ('p', NULL, 'default2'), ('unique_5', NULL, 'default1'), ('unique_6', '#', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_5', '#'), ('default2', 'br', 'default2'), ('unique_5', 'br', '#'), ('p', 'unique_6', 'unique_6'), ('p', '#', 'unique_8'), ('default2', 'default1', 'default1'), ('unique_5', 'default1', 'unique_8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "atom"."atom_id") FROM "atom" INNER JOIN "bond" ON "atom"."molecule_id" = "bond"."molecule_id" INNER JOIN "connected" ON "bond"."bond_id" = "connected"."bond_id" WHERE "bond"."bond_type" = '#' AND ("atom"."element" = 'p' OR "atom"."element" = 'br');

/*
Prediction Result:
(0,)
*/