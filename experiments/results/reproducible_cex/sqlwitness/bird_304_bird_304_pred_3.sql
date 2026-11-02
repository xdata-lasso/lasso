-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('+', 'default1'), ('default1', 'default2'), ('unique_3', NULL), ('unique_4', '+'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', '+'), ('unique_11', 'default1'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', '+'), ('unique_15', 'default2'), ('unique_16', 'default2'), ('unique_17', 'default2'), ('unique_18', 'default2'), ('unique_19', NULL), ('unique_20', 'default1'), ('unique_21', NULL), ('unique_22', NULL), ('unique_23', '+'), ('unique_24', 'default2'), ('unique_25', '+'), ('unique_26', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_10', 'default2'), ('+', 'unique_24', 'default1'), ('default1', 'unique_13', '+'), ('unique_3', 'unique_19', NULL), ('unique_4', 'unique_8', 'default2'), ('unique_5', 'unique_17', '+'), ('unique_6', 'unique_10', 'default1'), ('unique_7', 'unique_5', NULL), ('unique_8', 'unique_24', '+'), ('unique_9', 'unique_18', 'default1'), ('unique_10', 'unique_18', '+'), ('unique_11', 'unique_18', 'default1'), ('unique_12', 'unique_20', '+'), ('unique_13', 'unique_17', NULL), ('unique_14', 'unique_24', NULL), ('unique_15', 'unique_12', 'default1'), ('unique_16', 'unique_10', 'default2'), ('unique_17', 'unique_13', 'default2'), ('unique_18', '+', 'default2'), ('unique_19', 'unique_7', 'default2'), ('unique_20', 'unique_9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
('unique_10', 'default2')
('unique_10', 'default1')
*/

-- Prediction Query
SELECT T1.molecule_id, T2.element FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+';

/*
Prediction Result:
('unique_10', 'default2')
('unique_10', 'default1')
('unique_10', 'default2')
*/