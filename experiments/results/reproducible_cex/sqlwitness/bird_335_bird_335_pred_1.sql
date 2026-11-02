-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('=', NULL), ('default1', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', '=', 'default2'), ('default2', '=', 'o'), ('o', '=', 'default2'), ('default1', NULL, '='), ('unique_4', 'default1', 'default1'), ('unique_5', '=', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('o', '=', NULL), ('default2', '=', NULL), ('=', '=', 'o'), ('default1', NULL, '='), ('unique_4', NULL, 'o'), ('unique_5', '=', NULL), ('unique_6', '=', NULL), ('unique_7', 'default1', 'default2'), ('unique_8', NULL, 'default1'), ('unique_9', '=', NULL), ('unique_10', NULL, NULL), ('unique_11', NULL, 'o'), ('unique_12', 'default1', 'default2'), ('unique_13', 'default1', NULL), ('unique_14', 'default1', '='), ('unique_15', NULL, '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_15', 'unique_7', 'o'), ('unique_12', 'unique_13', '='), ('unique_13', 'unique_8', 'default1'), ('o', 'unique_15', 'unique_5'), ('o', 'unique_9', 'unique_4'), ('=', 'unique_15', 'default2'), ('unique_12', 'unique_7', 'default2'), ('default1', 'unique_9', '='), ('unique_7', 'default2', '='), ('o', 'unique_6', 'default2'), ('default1', 'unique_13', NULL), ('unique_6', 'unique_4', 'unique_4'), ('unique_15', 'default1', 'default1'), ('unique_13', 'unique_12', 'unique_5'), ('unique_8', 'unique_10', NULL), ('unique_14', '=', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "molecule"."molecule_id") FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" INNER JOIN "connected" ON "atom"."atom_id" = "connected"."atom_id" OR "atom"."atom_id" = "connected"."atom_id2" INNER JOIN "bond" ON "connected"."bond_id" = "bond"."bond_id" WHERE "atom"."element" = 'o' AND "bond"."bond_type" = '=';

/*
Prediction Result:
(0,)
*/