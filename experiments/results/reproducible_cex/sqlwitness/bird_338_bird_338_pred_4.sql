-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('TR012', 'TR012'), ('=', 'c'), ('c', 'default1'), ('default1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'TR012', '='), ('c', 'TR012', 'c'), ('TR012', NULL, 'TR012'), ('default2', NULL, 'default1'), ('=', '=', '='), ('unique_5', 'TR012', 'TR012'), ('unique_6', 'default2', NULL), ('unique_7', NULL, 'c'), ('unique_8', 'TR012', NULL), ('unique_9', 'c', NULL), ('unique_10', NULL, 'default2'), ('unique_11', '=', 'TR012'), ('unique_12', 'c', NULL), ('unique_13', NULL, '='), ('unique_14', 'TR012', 'TR012'), ('unique_15', 'c', '='), ('unique_16', 'c', 'c'), ('unique_17', 'default1', NULL), ('unique_18', 'default2', 'TR012'), ('unique_19', 'default1', 'c'), ('unique_20', 'c', 'c'), ('unique_21', 'TR012', NULL), ('unique_22', 'default2', 'default2'), ('unique_23', 'c', NULL), ('unique_24', 'default1', 'default2'), ('unique_25', '=', 'default1'), ('unique_26', 'default1', 'default1'), ('unique_27', NULL, '='), ('unique_28', 'default2', '='), ('unique_29', 'TR012', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('c', 'default1', 'default2'), ('default2', '=', NULL), ('default1', 'default2', '='), ('=', '=', 'default1'), ('TR012', 'default1', 'c'), ('unique_5', NULL, 'default2'), ('unique_6', 'TR012', 'default1'), ('unique_7', 'TR012', 'c'), ('unique_8', 'TR012', 'c'), ('unique_9', 'default1', 'TR012'), ('unique_10', 'default2', 'default2'), ('unique_11', 'c', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_9', 'unique_11', 'unique_11'), ('unique_10', 'unique_9', 'unique_15'), ('unique_6', 'unique_10', 'unique_21'), ('unique_8', 'default1', 'unique_8'), ('TR012', 'unique_7', 'unique_24'), ('unique_9', 'unique_6', '='), ('TR012', 'unique_6', '='), ('default1', 'unique_7', 'unique_19'), ('unique_8', 'c', 'unique_12'), ('=', 'unique_10', 'unique_5'), ('TR012', 'unique_5', 'unique_13'), ('default1', 'default1', 'unique_11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
('unique_7',)
('unique_8',)
*/

-- Prediction Query
SELECT a.atom_id FROM atom AS a JOIN bond AS b ON a.molecule_id = b.molecule_id JOIN connected AS c ON b.bond_id = c.bond_id WHERE a.element = 'c' AND b.bond_type = '=' AND a.molecule_id = 'TR012';

/*
Prediction Result:
*/