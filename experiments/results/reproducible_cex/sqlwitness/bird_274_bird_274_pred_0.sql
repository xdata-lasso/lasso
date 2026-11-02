-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', 'default1'), ('default1', 'default2'), ('default2', 'TR001'), ('unique_3', 'TR001'), ('unique_4', 'TR001'), ('unique_5', 'TR001'), ('unique_6', 'default2'), ('unique_7', 'TR001');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001', 'unique_4', NULL), ('default2', 'unique_3', 'TR001'), ('default1', 'unique_4', 'default2'), ('unique_3', 'TR001', 'TR001'), ('unique_4', 'default1', 'default1'), ('unique_5', 'unique_3', 'default2'), ('unique_6', 'default1', 'default1'), ('unique_7', NULL, 'default2'), ('unique_8', 'unique_6', 'default1'), ('unique_9', 'unique_4', NULL), ('unique_10', 'unique_5', 'TR001'), ('unique_11', 'TR001', 'default1'), ('unique_12', 'TR001', 'TR001'), ('unique_13', 'unique_5', 'default1'), ('unique_14', 'unique_6', 'default2'), ('unique_15', 'unique_5', NULL), ('unique_16', 'unique_4', NULL), ('unique_17', 'default2', 'TR001'), ('unique_18', 'unique_3', 'TR001'), ('unique_19', 'default1', 'TR001'), ('unique_20', 'unique_7', 'TR001'), ('unique_21', 'default2', 'default1'), ('unique_22', 'unique_4', NULL), ('unique_23', 'default2', 'default1'), ('unique_24', 'unique_5', 'default2'), ('unique_25', 'default1', NULL), ('unique_26', 'unique_4', 'default1'), ('unique_27', NULL, 'TR001'), ('unique_28', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE T.molecule_id = 'TR001';

/*
Gold Result:
('TR001',)
('default1',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR001';

/*
Prediction Result:
('TR001',)
('default1',)
('TR001',)
*/