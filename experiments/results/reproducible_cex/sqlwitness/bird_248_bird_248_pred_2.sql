-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR447', 'default2'), ('TR041', 'default1'), ('default1', 'default2'), ('#', 'default2'), ('default2', '#'), ('unique_5', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '#', 'default2'), ('TR447', '#', 'default1'), ('#', 'TR447', 'TR041'), ('default1', NULL, 'TR447'), ('TR041', 'unique_5', '#'), ('unique_5', 'TR041', '#'), ('unique_6', '#', NULL), ('unique_7', 'TR447', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default1', 'TR447'), ('default2', '#', 'default1'), ('TR447', 'unique_5', 'TR447'), ('#', 'TR041', 'TR447'), ('TR041', 'default1', 'TR041'), ('unique_5', 'default1', 'default1'), ('unique_6', NULL, 'TR041'), ('unique_7', 'TR447', 'TR447'), ('unique_8', 'default1', 'TR447'), ('unique_9', 'default2', 'default1'), ('unique_10', 'TR447', 'default2'), ('unique_11', 'default1', 'TR041'), ('unique_12', 'default2', 'default2'), ('unique_13', 'unique_5', 'TR447'), ('unique_14', 'default2', 'default2'), ('unique_15', '#', 'default1'), ('unique_16', '#', 'default2'), ('unique_17', 'default1', 'TR041'), ('unique_18', 'TR447', 'TR447'), ('unique_19', 'unique_5', '#'), ('unique_20', 'TR447', 'TR041'), ('unique_21', 'default1', 'default1'), ('unique_22', 'default2', NULL), ('unique_23', 'default1', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_12', 'unique_22', 'default1'), ('unique_7', 'unique_10', NULL), ('unique_9', 'unique_21', 'unique_6'), ('TR041', 'unique_21', 'unique_6'), ('unique_17', 'unique_13', '#'), ('TR041', 'unique_15', 'TR041'), ('unique_22', 'unique_8', 'default2'), ('default2', 'unique_8', 'unique_7'), ('unique_13', 'unique_11', 'unique_6'), ('unique_14', 'unique_14', 'unique_5'), ('unique_22', 'unique_14', 'default1'), ('unique_15', 'unique_23', 'TR041'), ('TR041', 'unique_11', NULL), ('unique_10', 'unique_7', 'unique_5'), ('unique_13', 'unique_10', '#'), ('unique_21', 'unique_21', 'unique_7'), ('unique_14', 'unique_11', 'TR041'), ('unique_5', 'unique_17', 'default2'), ('unique_14', 'TR041', '#'), ('unique_6', 'unique_5', 'unique_6'), ('TR447', '#', 'TR041'), ('unique_20', 'TR041', 'unique_6'), ('TR447', 'unique_19', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('default2', 'unique_8')
('unique_21', 'unique_21')
*/

-- Prediction Query
SELECT c.atom_id, c.atom_id2 FROM connected AS c JOIN bond AS b ON c.bond_id = b.bond_id JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
('unique_14', 'unique_14')
('unique_10', 'unique_7')
*/