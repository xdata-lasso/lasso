-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', 'default2'), ('default1', '#'), ('default2', NULL), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', '#'), ('unique_6', 'default2'), ('unique_7', '#'), ('unique_8', 'default2'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default1'), ('unique_14', '#'), ('unique_15', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, NULL), ('#', 'unique_9', 'default1'), ('default1', 'unique_6', NULL), ('unique_3', 'unique_8', '#'), ('unique_4', 'unique_9', 'default1'), ('unique_5', 'unique_4', 'default1'), ('unique_6', 'unique_10', 'default2'), ('unique_7', 'unique_10', 'default2'), ('unique_8', NULL, 'default2'), ('unique_9', NULL, 'default1'), ('unique_10', 'unique_10', '#'), ('unique_11', 'unique_8', NULL), ('unique_12', 'unique_11', 'default1'), ('unique_13', 'unique_3', NULL), ('unique_14', 'unique_10', '#'), ('unique_15', NULL, 'default1'), ('unique_16', 'unique_8', 'default1'), ('unique_17', NULL, NULL), ('unique_18', 'unique_14', NULL), ('unique_19', 'unique_13', NULL), ('unique_20', 'unique_10', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('#', 'unique_4', 'default2'), ('default1', 'default2', 'default1'), ('default2', 'unique_10', NULL), ('unique_3', 'unique_3', 'default1'), ('unique_4', 'unique_14', NULL), ('unique_5', 'unique_5', '#'), ('unique_6', 'unique_14', 'default2'), ('unique_7', 'unique_13', '#'), ('unique_8', '#', 'default1'), ('unique_9', 'unique_8', '#'), ('unique_10', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_9', NULL), ('unique_5', 'unique_10', 'unique_16'), ('unique_10', '#', 'unique_7'), ('default2', 'unique_6', 'unique_8'), ('unique_3', 'unique_5', '#'), ('unique_6', 'unique_3', 'unique_10'), ('#', '#', 'unique_20'), ('default1', 'unique_3', 'unique_20'), ('unique_7', 'unique_10', 'unique_10'), ('unique_3', '#', 'unique_14'), ('unique_5', '#', 'unique_10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '#';

/*
Gold Result:
('unique_6', 'unique_3')
('unique_7', 'unique_10')
('unique_3', '#')
('unique_5', '#')
*/

-- Prediction Query
SELECT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.bond_type = '#' LIMIT 2;

/*
Prediction Result:
('unique_6', 'unique_3')
('unique_7', 'unique_10')
*/