-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR004_8_9', 'default2'), ('default1', 'default1'), ('default2', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default1', 'TR004_8_9'), ('TR004_8_9', NULL, NULL), ('default1', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR004_8_9', NULL, NULL), ('default2', 'TR004_8_9', 'default2'), ('default1', 'default2', NULL), ('unique_3', 'TR004_8_9', 'TR004_8_9'), ('unique_4', 'TR004_8_9', 'default1'), ('unique_5', 'TR004_8_9', 'default2'), ('unique_6', NULL, 'TR004_8_9'), ('unique_7', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_8_9', 'unique_7', NULL), ('unique_3', 'unique_3', NULL), ('unique_3', 'default1', 'TR004_8_9'), ('unique_7', 'unique_7', 'default1'), ('unique_5', 'unique_4', 'default1'), ('unique_7', 'TR004_8_9', 'TR004_8_9'), ('default1', 'default1', 'TR004_8_9'), ('default1', 'unique_6', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('TR004_8_9',)
(None,)
*/

-- Prediction Query
SELECT T3.element FROM bond AS T1 JOIN connected AS T2 ON T1.bond_id = T2.bond_id JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_id = 'TR004_8_9';

/*
Prediction Result:
('TR004_8_9',)
(None,)
(None,)
*/