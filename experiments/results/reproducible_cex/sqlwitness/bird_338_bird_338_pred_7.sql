-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('=', 'default2'), ('default1', 'c'), ('TR012', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR012', 'TR012', 'default2'), ('c', 'default1', 'c'), ('=', 'TR012', 'default2'), ('default1', 'TR012', 'default2'), ('default2', '=', 'c'), ('unique_5', NULL, 'TR012'), ('unique_6', '=', 'default1'), ('unique_7', 'default1', 'c'), ('unique_8', '=', 'c'), ('unique_9', NULL, NULL), ('unique_10', 'TR012', '='), ('unique_11', 'default1', 'TR012'), ('unique_12', 'TR012', 'default1'), ('unique_13', 'TR012', '='), ('unique_14', 'default1', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'TR012', 'TR012'), ('=', NULL, 'c'), ('c', 'default1', 'c'), ('TR012', 'default1', 'default2'), ('default1', '=', 'TR012'), ('unique_5', '=', 'default1'), ('unique_6', NULL, '='), ('unique_7', 'TR012', NULL), ('unique_8', 'TR012', 'default2'), ('unique_9', '=', 'c'), ('unique_10', NULL, NULL), ('unique_11', 'default1', '='), ('unique_12', '=', 'default1'), ('unique_13', '=', 'TR012'), ('unique_14', 'default1', 'c'), ('unique_15', 'TR012', 'default2'), ('unique_16', 'TR012', 'TR012'), ('unique_17', 'default1', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', '=', 'unique_7'), ('unique_8', 'unique_7', 'TR012'), ('unique_17', 'default2', 'unique_6'), ('unique_10', 'unique_17', 'unique_8'), ('=', 'unique_13', 'unique_13'), ('unique_5', 'unique_16', 'unique_14'), ('default2', 'default2', NULL), ('default1', 'unique_10', 'unique_9'), ('unique_15', 'unique_9', 'unique_10'), ('unique_13', 'TR012', 'unique_6'), ('TR012', 'unique_16', 'unique_8'), ('unique_9', 'unique_6', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT a.atom_id FROM atom AS a INNER JOIN connected AS c ON a.atom_id = c.atom_id INNER JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.element = 'c' AND b.molecule_id = 'TR012' AND b.bond_type = '=';

/*
Prediction Result:
('=',)
*/