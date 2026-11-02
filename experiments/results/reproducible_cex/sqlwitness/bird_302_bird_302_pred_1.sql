-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_4', NULL, NULL), ('default1', NULL, 'TR001_2_4'), ('default2', NULL, 'TR001_2_4'), ('unique_3', NULL, 'default2'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, NULL), ('unique_6', NULL, NULL), ('unique_7', NULL, 'default2'), ('unique_8', NULL, NULL), ('unique_9', NULL, 'default1'), ('unique_10', NULL, 'default1'), ('unique_11', NULL, NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, NULL), ('TR001_2_4', NULL, 'default2'), ('default2', NULL, NULL), ('unique_3', NULL, 'default1'), ('unique_4', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'TR001_2_4', 'default1'), ('unique_3', 'TR001_2_4', 'unique_4'), ('default2', 'unique_4', 'TR001_2_4'), ('default1', 'default2', 'default1'), ('unique_3', 'unique_3', 'unique_10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT COALESCE(T2.element, T4.element) AS element FROM connected AS T1 LEFT JOIN atom AS T2 ON T1.atom_id = T2.atom_id LEFT JOIN atom AS T4 ON T1.atom_id2 = T4.atom_id WHERE T1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('default2',)
*/