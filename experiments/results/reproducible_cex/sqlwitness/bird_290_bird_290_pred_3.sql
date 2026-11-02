-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'TR151'), ('TR151', 'default1'), ('default2', 'TR151'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', 'TR151'), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'default2'), ('unique_10', 'TR151'), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'TR151'), ('unique_14', 'default1'), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', 'default2'), ('unique_19', NULL), ('unique_20', 'default1'), ('unique_21', 'default1'), ('unique_22', 'default1'), ('unique_23', 'TR151'), ('unique_24', NULL), ('unique_25', 'TR151'), ('unique_26', 'default2'), ('unique_27', 'default1'), ('unique_28', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_23', 'default1'), ('TR151', 'unique_14', 'TR151'), ('default2', 'unique_22', 'TR151'), ('unique_3', 'unique_25', 'TR151'), ('unique_4', 'unique_7', 'default1'), ('unique_5', 'unique_23', 'default2'), ('unique_6', 'unique_13', 'default1'), ('unique_7', 'unique_7', 'TR151'), ('unique_8', NULL, 'TR151'), ('unique_9', 'unique_19', NULL), ('unique_10', 'TR151', 'default1'), ('unique_11', 'unique_23', 'default1'), ('unique_12', 'unique_4', 'TR151'), ('unique_13', 'unique_14', 'default1'), ('unique_14', 'unique_12', NULL), ('unique_15', NULL, 'default1'), ('unique_16', 'unique_9', 'TR151'), ('unique_17', 'unique_11', 'TR151'), ('unique_18', 'TR151', 'default2'), ('unique_19', 'unique_3', 'default1'), ('unique_20', 'unique_6', 'default1'), ('unique_21', 'unique_17', NULL), ('unique_22', 'unique_24', 'default2'), ('unique_23', 'unique_15', 'default2'), ('unique_24', NULL, 'TR151'), ('unique_25', 'default2', 'default1'), ('unique_26', 'unique_13', 'default1'), ('unique_27', 'TR151', 'default1'), ('unique_28', 'unique_7', NULL), ('unique_29', 'unique_14', NULL), ('unique_30', 'unique_4', 'TR151'), ('unique_31', 'unique_20', 'TR151');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR151';

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT element FROM atom WHERE molecule_id = 'TR151';

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
*/