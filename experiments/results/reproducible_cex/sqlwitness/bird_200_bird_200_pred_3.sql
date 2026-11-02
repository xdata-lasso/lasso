-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', 'default2'), ('+', 'default2'), ('default2', 'default2'), ('default1', '+'), ('unique_4', 'default2'), ('unique_5', '#'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', '#'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', '+'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', 'default1'), ('unique_18', NULL), ('unique_19', NULL), ('unique_20', 'default2'), ('unique_21', 'default1'), ('unique_22', 'default1'), ('unique_23', NULL), ('unique_24', '+'), ('unique_25', '+'), ('unique_26', 'default2'), ('unique_27', '#'), ('unique_28', '+'), ('unique_29', '#'), ('unique_30', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('#', 'default1', '#'), ('+', 'unique_12', 'default1'), ('default2', 'default2', '+'), ('default1', 'unique_19', '+'), ('unique_4', 'default1', '#'), ('unique_5', 'unique_16', '+'), ('unique_6', 'unique_17', 'default1'), ('unique_7', NULL, 'default1'), ('unique_8', 'unique_17', '+'), ('unique_9', 'unique_21', '+'), ('unique_10', 'unique_13', '#'), ('unique_11', 'unique_8', '+'), ('unique_12', 'default1', '#'), ('unique_13', 'unique_20', '#'), ('unique_14', 'unique_16', 'default1'), ('unique_15', 'unique_26', 'default2'), ('unique_16', 'unique_17', 'default2'), ('unique_17', '#', 'default1'), ('unique_18', 'unique_20', 'default2'), ('unique_19', 'unique_20', NULL), ('unique_20', 'unique_22', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#' AND T2.label = '+';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#' AND T2.label = '+';

/*
Prediction Result:
('default1',)
('default1',)
('default1',)
*/