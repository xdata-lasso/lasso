-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default1'), ('TR001_10_11', NULL, 'TR001_10_11'), ('default1', NULL, 'default2'), ('unique_3', NULL, 'default2'), ('unique_4', NULL, 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, NULL), ('TR001_10_11', NULL, 'default1'), ('default1', NULL, NULL), ('unique_3', NULL, 'default1'), ('unique_4', NULL, NULL), ('unique_5', NULL, 'TR001_10_11'), ('unique_6', NULL, 'default1'), ('unique_7', NULL, 'default1'), ('unique_8', NULL, 'default1'), ('unique_9', NULL, 'default1'), ('unique_10', NULL, 'TR001_10_11'), ('unique_11', NULL, NULL), ('unique_12', NULL, 'default1'), ('unique_13', NULL, 'default1'), ('unique_14', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_7', 'unique_7', 'unique_3'), ('unique_10', 'TR001_10_11', 'unique_4'), ('TR001_10_11', 'unique_13', 'TR001_10_11'), ('unique_11', 'unique_9', 'TR001_10_11'), ('unique_13', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
('default1',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT t3.element FROM connected AS t1 INNER JOIN atom AS t2 ON t1.atom_id = t2.atom_id INNER JOIN atom AS t3 ON t1.atom_id2 = t3.atom_id WHERE t1.bond_id = 'TR001_10_11';

/*
Prediction Result:
('default1',)
*/