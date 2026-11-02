-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('i', 'default1'), ('default2', 'i'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_8', 'default2'), ('default1', 'unique_9', 'i'), ('i', 'unique_5', 'default2'), ('unique_3', 'unique_4', NULL), ('unique_4', 'default2', 'i'), ('unique_5', 'i', NULL), ('unique_6', 'unique_7', 'i'), ('unique_7', 'default1', 'i'), ('unique_8', 'unique_6', NULL), ('unique_9', 'default2', 'default2'), ('unique_10', 'default2', 'default1'), ('unique_11', 'unique_4', 'i'), ('unique_12', 'unique_4', 'default1'), ('unique_13', 'unique_4', NULL), ('unique_14', 'unique_9', 'default1'), ('unique_15', 'unique_9', 'default2'), ('unique_16', 'i', 'default1'), ('unique_17', 'unique_9', 'i'), ('unique_18', 'unique_7', 'default2'), ('unique_19', 'unique_5', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_4', 'default2'), ('i', 'i', NULL), ('default1', 'unique_3', 'default2'), ('unique_3', 'default2', 'i'), ('unique_4', NULL, 'default2'), ('unique_5', 'default1', 'default1'), ('unique_6', 'unique_4', NULL), ('unique_7', 'unique_4', 'default1'), ('unique_8', 'unique_9', 'default1'), ('unique_9', 'unique_5', NULL), ('unique_10', NULL, 'default2'), ('unique_11', 'default1', 'default1'), ('unique_12', 'unique_6', 'i'), ('unique_13', 'unique_5', NULL), ('unique_14', 'i', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('i', 'unique_4', NULL), ('unique_6', 'unique_5', 'unique_12'), ('default2', 'unique_12', 'unique_19'), ('unique_9', 'unique_6', NULL), ('default2', 'default2', 'unique_13'), ('unique_9', 'unique_9', 'unique_4'), ('unique_12', 'unique_9', 'unique_5'), ('unique_9', 'unique_7', 'unique_15'), ('unique_12', 'unique_6', 'unique_10'), ('unique_9', 'unique_11', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT CAST(COUNT("connected"."bond_id") AS REAL) / COUNT(DISTINCT "atom"."atom_id") FROM "connected" INNER JOIN "atom" ON "connected"."atom_id" = "atom"."atom_id" WHERE "atom"."element" = 'i';

/*
Prediction Result:
(2.0,)
*/