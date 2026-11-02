-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('TR447', 'default2'), ('default2', '#'), ('TR041', 'TR041'), ('#', NULL), ('unique_5', NULL), ('unique_6', 'TR447'), ('unique_7', 'TR447');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_7', '#'), ('TR447', 'unique_7', NULL), ('#', 'default2', '#'), ('TR041', 'default2', NULL), ('default2', 'TR447', '#'), ('unique_5', 'TR041', 'TR447'), ('unique_6', NULL, 'TR447'), ('unique_7', 'TR447', 'TR447'), ('unique_8', 'TR041', '#'), ('unique_9', 'default1', 'default1'), ('unique_10', 'default1', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR041', 'unique_7', 'default2'), ('TR447', 'default2', 'TR041'), ('default2', 'TR041', 'TR041'), ('#', 'unique_5', 'default1'), ('default1', 'TR041', 'TR447'), ('unique_5', '#', 'TR041'), ('unique_6', NULL, 'TR041'), ('unique_7', '#', NULL), ('unique_8', 'TR447', NULL), ('unique_9', 'default1', 'default1'), ('unique_10', 'TR041', 'TR447'), ('unique_11', '#', 'TR447'), ('unique_12', 'unique_7', NULL), ('unique_13', 'default1', 'default1'), ('unique_14', 'unique_6', NULL), ('unique_15', 'unique_6', 'TR041'), ('unique_16', 'unique_7', NULL), ('unique_17', 'TR447', 'default1'), ('unique_18', 'unique_5', 'TR447'), ('unique_19', 'default2', 'TR041'), ('unique_20', 'unique_6', '#'), ('unique_21', 'unique_6', '#'), ('unique_22', NULL, '#'), ('unique_23', NULL, 'TR041'), ('unique_24', 'TR447', 'default1'), ('unique_25', 'default1', 'TR041');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'unique_9', 'TR041'), ('TR041', 'default2', 'unique_8'), ('unique_16', 'unique_13', 'unique_5'), ('unique_22', 'unique_5', NULL), ('unique_17', 'unique_20', 'default2'), ('unique_14', 'unique_17', 'unique_8'), ('unique_13', 'unique_20', 'unique_10'), ('unique_25', 'unique_9', 'unique_5'), ('TR041', 'TR041', 'unique_7'), ('unique_25', 'TR447', 'default2'), ('unique_5', 'unique_5', '#'), ('unique_25', 'unique_20', 'default1'), ('unique_19', 'default2', 'default2'), ('unique_14', '#', 'TR447'), ('unique_7', 'unique_8', 'TR447'), ('unique_8', 'default2', 'unique_7'), ('unique_12', 'TR447', 'unique_7'), ('unique_15', 'TR041', 'default1'), ('default2', 'unique_5', 'unique_10'), ('TR041', 'unique_22', 'TR041');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('unique_17', 'unique_20')
('unique_25', 'TR447')
('unique_19', 'default2')
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM connected AS c INNER JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
('TR041', 'default2')
('unique_14', 'unique_17')
*/