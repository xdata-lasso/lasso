-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 's'), ('s', NULL), ('=', 's'), ('default1', 'default1'), ('unique_4', 's'), ('unique_5', NULL), ('unique_6', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('s', NULL, 'default1'), ('default1', '=', NULL), ('default2', 'unique_4', NULL), ('=', 'default1', 's'), ('unique_4', 'unique_5', 'default1'), ('unique_5', 'unique_4', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('=', NULL, '='), ('default2', 'default2', 'default1'), ('s', 'unique_5', 'default1'), ('default1', 'default1', 'default2'), ('unique_4', 'unique_5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "molecule"."molecule_id") FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" LEFT JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "atom"."element" <> 's' AND ("bond"."bond_type" IS NULL OR "bond"."bond_type" <> '=');

/*
Prediction Result:
(3,)
*/