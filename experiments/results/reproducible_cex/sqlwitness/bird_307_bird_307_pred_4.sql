-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default2'), ('default1', 'default1'), ('TR000_2_3', NULL), ('unique_3', NULL), ('unique_4', 'TR000_2_3'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'TR000_2_3');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'TR000_2_3', 'default2'), ('default2', 'unique_5', 'default2'), ('TR000_2_3', 'default2', 'TR000_2_3');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_4', 'TR000_2_3'), ('default2', 'unique_3', 'default2'), ('TR000_2_3', 'unique_5', 'default2'), ('unique_3', 'unique_6', 'default1'), ('unique_4', 'unique_5', 'TR000_2_3'), ('unique_5', 'default1', NULL), ('unique_6', 'unique_6', 'default2'), ('unique_7', 'default1', 'default1'), ('unique_8', 'unique_7', 'default1'), ('unique_9', 'unique_5', 'default2'), ('unique_10', 'TR000_2_3', 'TR000_2_3'), ('unique_11', 'default2', 'default1'), ('unique_12', 'unique_3', NULL), ('unique_13', NULL, 'TR000_2_3'), ('unique_14', 'unique_7', NULL), ('unique_15', 'unique_5', 'default2'), ('unique_16', 'TR000_2_3', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_11', 'unique_5', 'TR000_2_3'), ('unique_7', 'unique_13', NULL), ('unique_13', 'unique_14', NULL), ('default1', 'unique_9', 'TR000_2_3'), ('unique_15', 'unique_11', 'TR000_2_3'), ('unique_5', 'unique_13', 'TR000_2_3'), ('unique_7', 'unique_7', NULL), ('unique_16', 'unique_3', 'default2'), ('unique_5', 'unique_5', 'TR000_2_3'), ('unique_5', 'unique_3', 'TR000_2_3'), ('unique_11', 'unique_11', 'TR000_2_3'), ('default2', 'unique_15', 'TR000_2_3'), ('unique_12', 'default2', 'default1'), ('unique_3', 'unique_12', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('default1',)
('TR000_2_3',)
('default2',)
(None,)
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T1.element FROM atom AS T1 JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR000_2_3';

/*
Prediction Result:
('default1',)
('TR000_2_3',)
('default2',)
(None,)
*/