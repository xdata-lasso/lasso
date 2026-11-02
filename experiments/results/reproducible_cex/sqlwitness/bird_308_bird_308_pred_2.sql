-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('cl', 'cl'), ('default1', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('cl', 'default1', NULL), ('default2', 'cl', NULL), ('default1', 'default1', 'default1'), ('unique_3', 'default1', 'cl'), ('unique_4', 'default1', 'cl'), ('unique_5', NULL, 'default2'), ('unique_6', NULL, 'default1'), ('unique_7', 'default1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'cl'), ('cl', 'cl', NULL), ('default2', NULL, NULL), ('unique_3', NULL, 'cl');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'default2', 'default2'), ('cl', 'default1', 'cl'), ('default1', 'default1', 'default1'), ('default2', 'default2', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "connected"."bond_id") FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" OR "connected"."atom_id2" = "atom"."atom_id" WHERE "atom"."element" = 'cl';

/*
Prediction Result:
(3,)
*/