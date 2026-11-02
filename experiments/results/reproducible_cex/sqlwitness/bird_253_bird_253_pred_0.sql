-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('default2', 'default1'), ('#', 'default1'), ('unique_3', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, '#'), ('default1', 'default2', NULL), ('#', NULL, '#'), ('unique_3', '#', '#'), ('unique_4', NULL, 'default2'), ('unique_5', 'default2', NULL), ('unique_6', 'unique_3', 'default2'), ('unique_7', NULL, '#'), ('unique_8', 'default2', NULL), ('unique_9', NULL, NULL), ('unique_10', 'unique_3', 'default1'), ('unique_11', 'unique_3', 'default2'), ('unique_12', 'default2', 'default1'), ('unique_13', '#', 'default2'), ('unique_14', NULL, '#'), ('unique_15', NULL, 'default2'), ('unique_16', '#', 'default2'), ('unique_17', 'default1', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_3', NULL), ('default2', 'default2', 'default2'), ('#', 'default2', 'default1'), ('unique_3', 'default2', NULL), ('unique_4', 'unique_3', 'default2'), ('unique_5', '#', 'default2'), ('unique_6', NULL, '#'), ('unique_7', 'unique_3', 'default1'), ('unique_8', '#', 'default2'), ('unique_9', 'unique_3', '#'), ('unique_10', 'default2', NULL), ('unique_11', NULL, 'default1'), ('unique_12', 'default1', '#'), ('unique_13', 'default2', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'unique_10', '#'), ('unique_9', 'unique_11', 'unique_7'), ('unique_4', 'unique_9', 'unique_11'), ('unique_5', 'unique_8', 'unique_3'), ('unique_10', 'unique_7', 'unique_17'), ('#', 'unique_3', 'unique_11'), ('unique_7', 'default1', '#'), ('unique_4', 'unique_6', 'default1'), ('default1', '#', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('default2',)
('#',)
('default1',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#';

/*
Prediction Result:
('default2',)
('#',)
('default2',)
('default1',)
*/