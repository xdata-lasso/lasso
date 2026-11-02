-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default2'), ('TR012', 'default2'), ('=', NULL), ('c', 'TR012'), ('default1', 'default1'), ('unique_5', 'c'), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('c', 'c', 'c'), ('default1', 'default2', 'TR012'), ('=', 'default1', 'c'), ('default2', 'unique_6', 'default1'), ('TR012', '=', 'c'), ('unique_5', 'c', 'c'), ('unique_6', 'TR012', NULL), ('unique_7', NULL, 'default1'), ('unique_8', 'default1', 'TR012'), ('unique_9', 'unique_7', NULL), ('unique_10', 'c', 'TR012'), ('unique_11', 'default2', 'TR012'), ('unique_12', 'unique_8', 'default1'), ('unique_13', 'TR012', '='), ('unique_14', 'unique_7', 'TR012'), ('unique_15', 'unique_8', 'c'), ('unique_16', 'default1', NULL), ('unique_17', 'default1', NULL), ('unique_18', 'unique_7', NULL), ('unique_19', 'TR012', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_6', 'default1'), ('default2', '=', 'c'), ('c', 'c', 'default1'), ('=', NULL, 'TR012'), ('TR012', 'unique_5', 'default1'), ('unique_5', 'unique_5', 'TR012'), ('unique_6', 'unique_6', 'TR012'), ('unique_7', 'c', 'c'), ('unique_8', 'TR012', 'default1'), ('unique_9', 'TR012', 'c'), ('unique_10', 'unique_6', 'TR012'), ('unique_11', 'default1', 'default2'), ('unique_12', 'default1', 'TR012'), ('unique_13', 'c', 'c'), ('unique_14', 'default1', '='), ('unique_15', NULL, '='), ('unique_16', 'TR012', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'default2', 'unique_8'), ('=', 'unique_9', 'unique_14'), ('=', 'c', 'TR012'), ('unique_7', 'c', '='), ('default2', 'unique_15', 'unique_13'), ('unique_15', 'unique_16', 'unique_15'), ('unique_12', 'unique_6', 'unique_5'), ('unique_16', 'unique_13', 'unique_12'), ('unique_10', 'c', 'unique_13'), ('default2', 'unique_12', 'unique_18'), ('default2', 'TR012', 'unique_17'), ('default2', 'unique_6', 'unique_8'), ('c', 'unique_12', 'c'), ('unique_10', 'unique_16', 'unique_15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('unique_9',)
*/

-- Prediction Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id JOIN connected AS T3 ON T1.atom_id = T3.atom_id OR T1.atom_id = T3.atom_id2 JOIN bond AS T4 ON T3.bond_id = T4.bond_id WHERE T2.molecule_id = 'TR012' AND T1.element = 'c' AND T4.bond_type = '=';

/*
Prediction Result:
*/