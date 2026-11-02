-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', NULL), ('default2', 'default2'), ('cl', 'default2'), ('default1', '+'), ('unique_4', 'cl'), ('unique_5', NULL), ('unique_6', 'cl'), ('unique_7', NULL), ('unique_8', 'cl'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', 'cl'), ('unique_13', NULL), ('unique_14', '+'), ('unique_15', 'default2'), ('unique_16', 'default1'), ('unique_17', 'cl'), ('unique_18', 'default1'), ('unique_19', 'cl'), ('unique_20', NULL), ('unique_21', '+'), ('unique_22', 'default2'), ('unique_23', 'default2'), ('unique_24', 'default1'), ('unique_25', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'default1'), ('default1', 'unique_10', 'cl'), ('cl', NULL, 'default1'), ('+', 'default1', '+'), ('unique_4', 'unique_19', NULL), ('unique_5', 'unique_25', '+'), ('unique_6', 'unique_19', 'cl'), ('unique_7', 'unique_16', 'default2'), ('unique_8', 'unique_12', '+'), ('unique_9', 'unique_7', 'default1'), ('unique_10', 'unique_12', NULL), ('unique_11', 'default1', 'cl'), ('unique_12', 'unique_10', NULL), ('unique_13', 'unique_16', 'default2'), ('unique_14', 'unique_8', 'default2'), ('unique_15', 'unique_20', 'default2'), ('unique_16', 'unique_20', 'cl'), ('unique_17', 'unique_25', 'default1'), ('unique_18', 'unique_12', 'cl'), ('unique_19', 'unique_23', NULL), ('unique_20', 'unique_14', 'cl'), ('unique_21', 'default1', 'default2'), ('unique_22', 'cl', '+'), ('unique_23', 'default1', '+'), ('unique_24', 'unique_11', 'default1'), ('unique_25', 'unique_14', 'cl'), ('unique_26', 'unique_8', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('default1',)
('unique_14',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'cl' AND T1.label = '+';

/*
Prediction Result:
('default1',)
('unique_14',)
('unique_14',)
*/