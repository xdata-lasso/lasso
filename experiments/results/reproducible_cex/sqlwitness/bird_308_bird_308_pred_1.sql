-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('cl', NULL), ('default2', 'default2'), ('default1', 'default1'), ('unique_3', 'cl'), ('unique_4', 'default2'), ('unique_5', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', NULL, NULL), ('cl', 'default2', 'default1'), ('default2', 'default2', NULL), ('unique_3', 'unique_3', 'cl'), ('unique_4', 'default1', 'default2'), ('unique_5', 'cl', 'cl'), ('unique_6', 'unique_3', 'cl'), ('unique_7', 'cl', NULL), ('unique_8', 'default2', 'cl'), ('unique_9', 'unique_5', NULL), ('unique_10', 'unique_3', 'default1'), ('unique_11', 'unique_4', 'default2'), ('unique_12', 'default1', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('cl', NULL, 'cl'), ('default1', 'default1', NULL), ('default2', 'default2', 'cl'), ('unique_3', 'default1', 'default1'), ('unique_4', 'cl', 'default1'), ('unique_5', 'cl', 'default2'), ('unique_6', 'unique_5', 'cl'), ('unique_7', 'unique_5', NULL), ('unique_8', 'default1', 'default1'), ('unique_9', 'cl', NULL), ('unique_10', 'default2', 'default1'), ('unique_11', 'unique_5', 'default1'), ('unique_12', NULL, 'cl'), ('unique_13', 'unique_5', 'cl'), ('unique_14', 'unique_4', 'cl');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_7', 'unique_11'), ('default1', 'unique_8', NULL), ('unique_6', 'unique_8', 'unique_3'), ('unique_12', 'cl', 'unique_4'), ('unique_13', 'default2', 'unique_9'), ('unique_3', 'default2', 'unique_10'), ('unique_4', 'unique_7', 'unique_5'), ('unique_14', 'unique_12', 'unique_10'), ('unique_3', 'unique_11', 'default2'), ('unique_14', 'unique_9', 'unique_9'), ('unique_4', 'unique_8', 'unique_7'), ('unique_12', 'unique_13', 'unique_9'), ('unique_4', 'cl', 'unique_10'), ('unique_12', 'unique_12', 'default2'), ('unique_12', 'unique_4', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(8,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.bond_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'cl';

/*
Prediction Result:
(5,)
*/