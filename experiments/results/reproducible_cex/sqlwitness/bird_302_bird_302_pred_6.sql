-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('default2', 'default1'), ('TR001_2_4', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_4', 'default2', 'default2'), ('default1', 'default2', 'TR001_2_4'), ('default2', 'TR001_2_4', 'TR001_2_4'), ('unique_3', NULL, NULL), ('unique_4', 'default2', 'default1'), ('unique_5', 'default1', 'default2'), ('unique_6', NULL, 'TR001_2_4'), ('unique_7', NULL, 'TR001_2_4'), ('unique_8', 'default1', NULL), ('unique_9', 'default1', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'TR001_2_4'), ('TR001_2_4', 'TR001_2_4', NULL), ('default1', NULL, NULL), ('unique_3', NULL, 'default1'), ('unique_4', 'default1', 'TR001_2_4'), ('unique_5', 'TR001_2_4', 'default2'), ('unique_6', NULL, 'default2'), ('unique_7', NULL, 'TR001_2_4'), ('unique_8', 'default2', 'TR001_2_4'), ('unique_9', NULL, 'TR001_2_4'), ('unique_10', 'TR001_2_4', NULL), ('unique_11', 'default2', NULL), ('unique_12', 'TR001_2_4', NULL), ('unique_13', 'default2', NULL), ('unique_14', NULL, 'default1'), ('unique_15', 'TR001_2_4', 'default2'), ('unique_16', 'default2', 'TR001_2_4'), ('unique_17', 'TR001_2_4', 'default2'), ('unique_18', 'TR001_2_4', NULL), ('unique_19', 'default2', 'default1'), ('unique_20', 'default1', 'TR001_2_4'), ('unique_21', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'unique_14', 'unique_9'), ('unique_13', 'default1', 'unique_7'), ('unique_11', 'unique_15', 'unique_5'), ('default2', 'unique_12', 'unique_5'), ('unique_6', 'unique_4', 'default2'), ('unique_19', 'unique_5', 'TR001_2_4'), ('unique_8', 'unique_17', 'default1'), ('unique_6', 'unique_3', 'default1'), ('unique_5', 'unique_14', 'unique_3'), ('unique_7', 'unique_6', 'unique_7'), ('default1', 'unique_19', 'unique_6'), ('unique_15', 'unique_10', 'unique_6'), ('unique_19', 'TR001_2_4', 'unique_5'), ('unique_18', 'unique_8', 'unique_8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT t2.element FROM connected AS t1 INNER JOIN atom AS t2 ON t1.atom_id = t2.atom_id OR t1.atom_id2 = t2.atom_id WHERE t1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('default1',)
('default2',)
*/