-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('sn', NULL), ('default2', 'sn'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'sn'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'sn'), ('unique_11', 'default2'), ('unique_12', NULL), ('unique_13', 'sn'), ('unique_14', 'default2'), ('unique_15', 'default2'), ('unique_16', 'default2'), ('unique_17', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('sn', 'unique_7', 'sn'), ('default1', 'unique_6', 'default1'), ('default2', 'unique_8', NULL), ('unique_3', 'unique_7', 'default1'), ('unique_4', NULL, 'sn'), ('unique_5', NULL, NULL), ('unique_6', 'unique_9', NULL), ('unique_7', 'unique_17', 'default1'), ('unique_8', 'default2', 'sn');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_12', NULL), ('sn', 'unique_11', NULL), ('default1', 'unique_14', 'default2'), ('unique_3', NULL, 'default2'), ('unique_4', 'unique_8', 'default1'), ('unique_5', 'unique_5', 'sn'), ('unique_6', 'unique_13', NULL), ('unique_7', 'unique_6', NULL), ('unique_8', 'unique_9', 'default1'), ('unique_9', 'unique_4', 'default1'), ('unique_10', 'unique_13', 'default2'), ('unique_11', 'unique_8', 'sn'), ('unique_12', 'unique_17', NULL), ('unique_13', 'unique_3', 'default2'), ('unique_14', NULL, 'default1'), ('unique_15', NULL, 'default2'), ('unique_16', 'unique_17', 'default2'), ('unique_17', 'unique_6', 'default2'), ('unique_18', 'unique_14', 'sn'), ('unique_19', 'unique_11', 'sn'), ('unique_20', 'unique_17', 'default1'), ('unique_21', 'unique_10', NULL), ('unique_22', 'sn', NULL), ('unique_23', 'unique_8', 'default1'), ('unique_24', 'unique_13', 'sn'), ('unique_25', 'unique_7', 'sn'), ('unique_26', 'unique_9', 'sn'), ('unique_27', 'unique_12', NULL), ('unique_28', 'unique_12', 'default2'), ('unique_29', 'unique_13', 'default1'), ('unique_30', 'sn', NULL), ('unique_31', 'unique_8', NULL), ('unique_32', 'unique_14', NULL), ('unique_33', 'unique_17', 'default1'), ('unique_34', 'unique_12', 'sn');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', 'unique_16', 'unique_6'), ('default1', 'unique_4', 'default1'), ('unique_29', 'unique_26', 'default2'), ('unique_19', 'unique_18', 'unique_5'), ('unique_19', 'unique_4', 'default1'), ('unique_3', 'unique_8', 'default2'), ('unique_27', 'unique_19', 'unique_5'), ('unique_30', 'unique_22', NULL), ('unique_4', 'unique_14', 'unique_3'), ('unique_17', 'unique_25', 'default1'), ('unique_8', 'unique_32', 'unique_3'), ('unique_10', 'unique_30', 'sn'), ('unique_29', 'unique_8', 'unique_4'), ('unique_14', 'unique_30', 'unique_8'), ('unique_11', 'unique_21', NULL), ('unique_10', 'unique_22', 'default1'), ('unique_11', 'unique_19', 'unique_7'), ('unique_34', 'default2', 'unique_3'), ('unique_27', 'unique_18', 'unique_8'), ('unique_5', 'unique_29', 'unique_4'), ('unique_3', 'unique_20', 'default2'), ('unique_9', 'unique_34', 'unique_4'), ('unique_19', 'unique_31', NULL), ('unique_28', 'unique_25', 'unique_4'), ('unique_19', 'unique_3', 'unique_8'), ('unique_34', 'unique_24', 'sn'), ('unique_22', 'unique_3', NULL), ('unique_26', 'unique_30', 'unique_3'), ('unique_22', 'unique_14', 'unique_7'), ('sn', 'unique_15', 'default2'), ('unique_31', 'default1', 'default1'), ('unique_18', 'unique_31', 'unique_7'), ('unique_11', 'unique_3', 'sn'), ('unique_25', 'unique_13', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
(None,)
('default1',)
('sn',)
*/

-- Prediction Query
SELECT T2.bond_type FROM atom AS T1 INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id INNER JOIN bond AS T2 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Prediction Result:
(None,)
(None,)
('default1',)
('default1',)
('default1',)
('sn',)
('sn',)
('sn',)
('default1',)
('default1',)
('sn',)
(None,)
*/