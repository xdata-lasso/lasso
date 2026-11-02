-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR001_10_11', NULL), ('default1', 'default1'), ('default2', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default2'), ('unique_12', 'TR001_10_11'), ('unique_13', 'default1'), ('unique_14', 'TR001_10_11');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_8', 'default1'), ('TR001_10_11', 'unique_13', 'default1'), ('default1', 'unique_7', 'default1'), ('unique_3', 'unique_5', 'default2'), ('unique_4', 'unique_5', NULL), ('unique_5', 'unique_4', 'default2'), ('unique_6', 'TR001_10_11', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_10_11', 'unique_5', 'default1'), ('default1', 'unique_12', 'default2'), ('default2', 'unique_8', 'TR001_10_11'), ('unique_3', 'unique_7', NULL), ('unique_4', 'unique_8', 'default2'), ('unique_5', 'default1', 'default1'), ('unique_6', 'unique_9', 'default2'), ('unique_7', 'unique_5', 'TR001_10_11'), ('unique_8', 'unique_9', 'TR001_10_11'), ('unique_9', 'default1', NULL), ('unique_10', 'unique_7', 'default2'), ('unique_11', 'unique_13', 'default2'), ('unique_12', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_9', 'unique_6', 'default1'), ('default1', 'TR001_10_11', 'unique_3'), ('unique_4', 'unique_5', 'TR001_10_11'), ('unique_5', 'default2', NULL), ('unique_12', 'default1', NULL), ('unique_8', 'unique_12', 'default2'), ('unique_11', 'unique_7', 'unique_3'), ('unique_5', 'unique_9', 'unique_6'), ('unique_4', 'unique_12', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR001_10_11';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT DISTINCT a."element" FROM "connected" AS c INNER JOIN "atom" AS a ON c."atom_id" = a."atom_id" OR c."atom_id2" = a."atom_id" WHERE c."bond_id" = 'TR001_10_11';

/*
Prediction Result:
('default2',)
('default1',)
*/