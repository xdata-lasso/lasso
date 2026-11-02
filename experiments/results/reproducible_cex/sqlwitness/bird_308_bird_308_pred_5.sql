-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'cl'), ('cl', NULL), ('default2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', 'cl'), ('unique_6', 'cl'), ('unique_7', 'cl'), ('unique_8', 'cl'), ('unique_9', 'cl'), ('unique_10', 'default2'), ('unique_11', 'cl'), ('unique_12', 'default2'), ('unique_13', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('cl', 'cl', 'default2'), ('default2', 'unique_6', 'default2'), ('default1', 'unique_6', 'cl'), ('unique_3', 'cl', 'default1'), ('unique_4', 'unique_8', 'cl'), ('unique_5', 'unique_13', 'default1'), ('unique_6', 'unique_13', 'default1'), ('unique_7', 'unique_12', NULL), ('unique_8', 'cl', NULL), ('unique_9', 'default2', 'default1'), ('unique_10', 'unique_13', NULL), ('unique_11', 'default1', 'default1'), ('unique_12', 'unique_7', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('cl', 'unique_8', NULL), ('unique_7', 'default2', NULL), ('unique_6', 'unique_12', NULL), ('default2', 'unique_5', NULL), ('unique_3', 'unique_4', NULL), ('unique_3', 'unique_10', NULL), ('unique_4', 'default1', NULL), ('default1', 'default2', NULL), ('default1', 'unique_7', NULL), ('unique_7', 'default1', NULL), ('cl', 'unique_9', NULL), ('unique_12', 'default1', NULL), ('unique_12', 'unique_10', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'cl';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT c.atom_id || c.atom_id2) AS bond_count FROM atom AS a INNER JOIN connected AS c ON a.atom_id = c.atom_id WHERE a.element = 'cl';

/*
Prediction Result:
(3,)
*/