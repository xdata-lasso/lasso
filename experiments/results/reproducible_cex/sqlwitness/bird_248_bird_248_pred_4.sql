-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('#', NULL), ('default2', 'TR447'), ('TR447', 'default1'), ('TR041', '#'), ('unique_5', 'TR041'), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'TR447'), ('unique_9', 'TR041'), ('unique_10', 'TR447'), ('unique_11', 'TR447');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR041', NULL, 'TR041'), ('default2', 'unique_8', 'TR041'), ('#', 'unique_7', '#'), ('TR447', 'unique_8', 'default1'), ('default1', 'unique_7', 'TR447'), ('unique_5', 'unique_7', 'default1'), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_8', NULL), ('unique_8', 'unique_5', 'TR447'), ('unique_9', 'unique_9', 'default1'), ('unique_10', 'unique_10', 'default2'), ('unique_11', 'unique_8', 'default1'), ('unique_12', NULL, 'default2'), ('unique_13', 'TR041', 'default2'), ('unique_14', 'TR447', NULL), ('unique_15', 'unique_5', '#'), ('unique_16', 'default2', 'TR447'), ('unique_17', NULL, 'default1'), ('unique_18', 'unique_9', 'default1'), ('unique_19', 'unique_11', 'default1'), ('unique_20', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_6', 'TR447'), ('TR447', 'unique_7', NULL), ('default1', 'TR041', '#'), ('TR041', NULL, 'TR041'), ('#', 'unique_10', '#'), ('unique_5', 'TR041', 'default1'), ('unique_6', 'TR041', NULL), ('unique_7', 'unique_8', 'TR447'), ('unique_8', '#', 'TR447'), ('unique_9', 'unique_5', 'default2'), ('unique_10', 'unique_10', NULL), ('unique_11', 'unique_6', NULL), ('unique_12', 'unique_8', 'default1'), ('unique_13', 'unique_11', '#'), ('unique_14', 'unique_9', 'default2'), ('unique_15', 'unique_5', 'default1'), ('unique_16', NULL, '#'), ('unique_17', 'TR447', 'default2'), ('unique_18', 'unique_11', 'TR041'), ('unique_19', 'TR447', 'default1'), ('unique_20', 'TR041', NULL), ('unique_21', NULL, 'default1'), ('unique_22', 'unique_9', 'TR041'), ('unique_23', '#', 'default1'), ('unique_24', 'unique_7', 'TR447'), ('unique_25', 'default2', 'TR447'), ('unique_26', 'default2', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR447', 'unique_16', 'unique_9'), ('TR447', 'unique_7', 'unique_8'), ('unique_5', 'default1', '#'), ('#', 'unique_6', 'unique_15'), ('unique_18', 'unique_12', 'unique_9'), ('unique_18', 'unique_11', 'unique_11'), ('unique_20', 'unique_11', 'unique_17'), ('unique_26', 'unique_16', 'unique_7'), ('unique_23', 'unique_12', 'TR041'), ('TR447', 'TR447', 'unique_18'), ('default2', 'default2', 'unique_17'), ('TR447', 'TR041', 'unique_8'), ('unique_9', 'unique_23', 'unique_17'), ('unique_12', 'unique_24', 'unique_14'), ('unique_16', 'unique_10', '#'), ('unique_6', 'unique_6', 'unique_16'), ('unique_22', 'default1', NULL), ('unique_10', 'unique_24', 'unique_20'), ('unique_21', 'unique_5', NULL), ('unique_17', 'unique_10', 'unique_11'), ('unique_8', 'unique_13', 'TR041'), ('unique_5', 'unique_20', 'unique_15'), ('unique_16', 'unique_5', 'TR447'), ('unique_17', 'unique_24', 'unique_19'), ('unique_22', 'unique_25', 'unique_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id INNER JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id INNER JOIN bond AS T4 ON T1.bond_id = T4.bond_id WHERE T2.molecule_id = 'TR041' AND T3.molecule_id = 'TR041' AND T4.bond_type = '#';

/*
Prediction Result:
('unique_5', 'default1')
('unique_5', 'unique_20')
*/