-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'TR004_8_9'), ('TR004_8_9', NULL, 'default1'), ('default1', NULL, 'TR004_8_9');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, NULL), ('TR004_8_9', NULL, 'TR004_8_9'), ('default2', NULL, 'default1'), ('unique_3', NULL, 'default1'), ('unique_4', NULL, 'default1'), ('unique_5', NULL, 'default2'), ('unique_6', NULL, NULL), ('unique_7', NULL, NULL), ('unique_8', NULL, NULL), ('unique_9', NULL, 'default1'), ('unique_10', NULL, 'default1'), ('unique_11', NULL, 'TR004_8_9'), ('unique_12', NULL, NULL), ('unique_13', NULL, 'default2'), ('unique_14', NULL, 'default1'), ('unique_15', NULL, 'TR004_8_9'), ('unique_16', NULL, NULL), ('unique_17', NULL, 'TR004_8_9'), ('unique_18', NULL, 'default2'), ('unique_19', NULL, NULL), ('unique_20', NULL, 'default2'), ('unique_21', NULL, 'default2'), ('unique_22', NULL, NULL), ('unique_23', NULL, 'default1'), ('unique_24', NULL, 'default1'), ('unique_25', NULL, 'default1'), ('unique_26', NULL, 'TR004_8_9'), ('unique_27', NULL, 'TR004_8_9'), ('unique_28', NULL, 'default2'), ('unique_29', NULL, 'TR004_8_9'), ('unique_30', NULL, NULL), ('unique_31', NULL, 'default2'), ('unique_32', NULL, 'TR004_8_9'), ('unique_33', NULL, 'default1'), ('unique_34', NULL, 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR004_8_9', 'unique_4', 'TR004_8_9'), ('default2', 'unique_29', 'TR004_8_9'), ('unique_27', 'default2', 'default2'), ('unique_10', 'unique_14', 'TR004_8_9'), ('unique_8', 'unique_10', NULL), ('unique_24', 'unique_5', NULL), ('unique_20', 'unique_12', 'default2'), ('unique_26', 'unique_16', 'TR004_8_9'), ('unique_32', 'unique_4', NULL), ('unique_18', 'unique_28', NULL), ('unique_6', 'unique_20', 'default2'), ('unique_10', 'unique_33', 'default2'), ('unique_7', 'unique_12', NULL), ('unique_9', 'unique_29', NULL), ('unique_19', 'unique_31', 'TR004_8_9'), ('unique_26', 'unique_29', 'default1'), ('unique_27', 'unique_24', 'default2'), ('default1', 'unique_6', NULL), ('unique_22', 'unique_18', 'TR004_8_9'), ('unique_6', 'unique_19', 'TR004_8_9'), ('unique_5', 'unique_3', 'TR004_8_9'), ('unique_28', 'unique_23', 'default2'), ('unique_6', 'unique_21', 'default1'), ('unique_8', 'unique_31', 'default2'), ('unique_31', 'unique_17', 'TR004_8_9'), ('unique_26', 'unique_27', 'default1'), ('default1', 'default1', 'default2'), ('unique_32', 'unique_25', NULL), ('unique_3', 'unique_11', NULL), ('unique_8', 'unique_21', 'default1'), ('unique_28', 'unique_28', 'TR004_8_9'), ('TR004_8_9', 'unique_11', NULL), ('unique_9', 'unique_34', 'default2'), ('TR004_8_9', 'unique_18', 'default1'), ('unique_21', 'unique_20', 'TR004_8_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Gold Result:
('TR004_8_9',)
('default1',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR004_8_9';

/*
Prediction Result:
('TR004_8_9',)
('default1',)
('default1',)
('TR004_8_9',)
(None,)
(None,)
(None,)
('default2',)
('default2',)
('default2',)
('default2',)
*/