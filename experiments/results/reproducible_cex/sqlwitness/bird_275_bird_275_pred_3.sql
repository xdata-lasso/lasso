-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', '='), ('=', 'default2'), ('default1', '='), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', '='), ('unique_10', '='), ('unique_11', '='), ('unique_12', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', 'unique_7', '='), ('default2', 'unique_10', 'default1'), ('default1', 'unique_8', 'default1'), ('unique_3', 'unique_4', NULL), ('unique_4', 'unique_12', 'default1'), ('unique_5', 'unique_9', '='), ('unique_6', 'unique_6', '='), ('unique_7', 'unique_10', 'default2'), ('unique_8', 'unique_4', 'default1'), ('unique_9', 'unique_12', NULL), ('unique_10', 'unique_11', NULL), ('unique_11', 'unique_3', '='), ('unique_12', 'unique_9', '='), ('unique_13', 'unique_3', '='), ('unique_14', 'unique_5', 'default1'), ('unique_15', 'unique_4', 'default2'), ('unique_16', 'default1', 'default2'), ('unique_17', 'unique_12', '='), ('unique_18', 'unique_11', NULL), ('unique_19', 'unique_4', 'default2'), ('unique_20', 'unique_4', '='), ('unique_21', 'unique_7', 'default1'), ('unique_22', 'unique_11', '='), ('unique_23', 'unique_3', '='), ('unique_24', 'unique_8', 'default1'), ('unique_25', 'unique_6', NULL), ('unique_26', 'unique_12', NULL), ('unique_27', 'unique_7', 'default1'), ('unique_28', 'default1', '='), ('unique_29', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.molecule_id FROM bond AS T WHERE T.bond_type = '=';

/*
Gold Result:
('unique_7',)
('unique_9',)
('unique_6',)
('unique_3',)
('unique_12',)
('unique_4',)
('unique_11',)
('default1',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM bond AS T1 WHERE T1.bond_type = '=';

/*
Prediction Result:
('unique_7',)
('unique_9',)
('unique_6',)
('unique_3',)
('unique_9',)
('unique_3',)
('unique_12',)
('unique_4',)
('unique_11',)
('unique_3',)
('default1',)
*/