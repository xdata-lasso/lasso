-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR024', 'default2'), ('default1', 'default1'), ('=', 'TR024'), ('default2', '='), ('unique_4', 'default2'), ('unique_5', 'TR024');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, NULL), ('=', 'default2', 'TR024'), ('default1', 'default2', 'default2'), ('TR024', NULL, 'default1'), ('unique_4', NULL, NULL), ('unique_5', NULL, 'TR024'), ('unique_6', 'unique_4', 'default2'), ('unique_7', NULL, 'TR024'), ('unique_8', 'TR024', '='), ('unique_9', 'unique_5', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR024', 'unique_5', '='), ('=', 'unique_4', 'default1'), ('default1', 'TR024', '='), ('default2', 'unique_5', '='), ('unique_4', 'default2', 'default2'), ('unique_5', NULL, 'default2'), ('unique_6', 'unique_5', 'default2'), ('unique_7', 'unique_4', NULL), ('unique_8', 'unique_5', 'default1'), ('unique_9', 'default2', 'default2'), ('unique_10', 'default1', 'default1'), ('unique_11', NULL, 'TR024'), ('unique_12', NULL, 'default2'), ('unique_13', NULL, 'default1'), ('unique_14', 'default2', '='), ('unique_15', 'unique_4', 'default2'), ('unique_16', '=', 'default2'), ('unique_17', 'TR024', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'unique_15', 'default1'), ('unique_12', '=', 'unique_6'), ('unique_17', 'default1', 'TR024'), ('unique_5', 'unique_14', 'unique_6'), ('unique_11', 'unique_11', 'unique_9'), ('unique_16', 'default2', NULL), ('unique_12', 'unique_16', 'default2'), ('unique_14', 'unique_7', 'unique_4'), ('TR024', 'unique_13', 'unique_5'), ('unique_13', '=', 'unique_4'), ('unique_13', 'default2', 'TR024'), ('unique_16', 'TR024', 'default2'), ('unique_10', 'unique_11', 'unique_6'), ('TR024', 'unique_11', NULL), ('unique_13', 'unique_10', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
('=',)
('default2',)
*/

-- Prediction Query
SELECT T3.element FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T3.atom_id = T1.atom_id WHERE T2.bond_type = '=' AND T2.molecule_id = 'TR024';

/*
Prediction Result:
*/