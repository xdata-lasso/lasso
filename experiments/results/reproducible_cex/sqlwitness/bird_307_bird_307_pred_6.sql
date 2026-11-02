-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR000_2_3', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'TR000_2_3', 'TR000_2_3'), ('TR000_2_3', 'TR000_2_3', 'TR000_2_3'), ('default1', 'TR000_2_3', 'TR000_2_3'), ('unique_3', NULL, 'default1'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, 'default2'), ('unique_6', 'TR000_2_3', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'TR000_2_3', 'TR000_2_3'), ('default2', NULL, 'TR000_2_3'), ('TR000_2_3', 'TR000_2_3', 'default1'), ('unique_3', NULL, 'default1'), ('unique_4', 'TR000_2_3', 'default1'), ('unique_5', 'TR000_2_3', NULL), ('unique_6', NULL, 'default2'), ('unique_7', 'TR000_2_3', NULL), ('unique_8', NULL, 'TR000_2_3'), ('unique_9', 'TR000_2_3', 'default2'), ('unique_10', NULL, 'default2'), ('unique_11', 'TR000_2_3', 'default1'), ('unique_12', 'TR000_2_3', 'default1'), ('unique_13', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_8', 'unique_3'), ('unique_9', 'unique_10', 'TR000_2_3'), ('unique_8', 'unique_6', 'default2'), ('unique_9', 'default1', 'unique_4'), ('unique_5', 'unique_5', 'unique_3'), ('unique_11', 'unique_5', 'unique_6'), ('TR000_2_3', 'unique_11', 'unique_4'), ('unique_10', 'unique_12', NULL), ('default1', 'unique_3', NULL), ('unique_4', 'unique_3', 'default1'), ('unique_5', 'unique_9', 'unique_3'), ('default1', 'default1', 'unique_6'), ('unique_11', 'unique_13', 'TR000_2_3'), ('unique_5', 'unique_6', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Gold Result:
('default2',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T2.element, T3.element FROM connected AS T1 JOIN atom AS T2 ON T1.atom_id = T2.atom_id JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id WHERE T1.bond_id = 'TR000_2_3';

/*
Prediction Result:
('default2', 'default2')
('default1', None)
*/