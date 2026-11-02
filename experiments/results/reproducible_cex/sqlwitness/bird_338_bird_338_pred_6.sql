-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES (' = ', NULL), ('=', 'TR012'), ('TR012', NULL), ('c', '='), ('default2', 'default1'), ('default1', '='), ('unique_6', ' = '), ('unique_7', NULL), ('unique_8', '='), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', 'c'), ('unique_13', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('c', 'unique_11', 'TR012'), ('TR012', 'TR012', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', ' = ', '='), ('c', 'unique_12', 'default2'), ('default2', 'unique_8', ' = '), (' = ', ' = ', NULL), ('TR012', 'unique_9', ' = '), ('=', '=', 'TR012'), ('unique_6', 'c', 'TR012'), ('unique_7', 'unique_10', NULL), ('unique_8', NULL, 'c'), ('unique_9', NULL, ' = '), ('unique_10', '=', 'c'), ('unique_11', NULL, NULL), ('unique_12', 'unique_10', 'default1'), ('unique_13', 'unique_9', ' = '), ('unique_14', ' = ', NULL), ('unique_15', '=', 'default1'), ('unique_16', 'TR012', 'TR012'), ('unique_17', 'unique_10', NULL), ('unique_18', 'TR012', 'c'), ('unique_19', 'c', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_10', 'TR012'), ('c', 'unique_6', 'TR012'), ('unique_14', 'unique_15', 'TR012'), ('unique_12', 'unique_9', 'c'), (' = ', 'unique_9', NULL), ('unique_11', 'unique_13', 'c'), ('unique_15', 'unique_13', 'TR012'), ('unique_15', 'unique_8', NULL), ('unique_9', 'unique_10', 'c'), ('default2', 'unique_10', NULL), ('unique_14', ' = ', 'c'), ('unique_18', 'unique_7', 'c'), ('unique_17', 'unique_11', 'c'), ('TR012', 'unique_10', NULL), ('=', 'unique_19', 'TR012'), ('unique_13', 'unique_12', 'TR012'), ('unique_16', 'unique_7', 'c'), ('unique_16', 'c', NULL), ('unique_14', 'unique_8', 'TR012'), ('default2', 'unique_8', 'TR012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('unique_18',)
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T1.element = 'c' AND T2.bond_type = ' = ' AND T2.molecule_id = 'TR012';

/*
Prediction Result:
*/