-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', 'default1'), ('cl', 'default1'), ('default1', '+'), ('default2', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', 'cl'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', '+'), ('unique_10', 'cl'), ('unique_11', 'default2'), ('unique_12', 'default2'), ('unique_13', '+'), ('unique_14', 'cl'), ('unique_15', 'default2'), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', 'cl'), ('unique_19', NULL), ('unique_20', 'default1'), ('unique_21', 'default1'), ('unique_22', 'default1'), ('unique_23', 'cl'), ('unique_24', 'cl'), ('unique_25', 'default2'), ('unique_26', 'cl'), ('unique_27', '+'), ('unique_28', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_21', '+'), ('cl', 'unique_27', 'cl'), ('+', NULL, 'cl'), ('default1', 'unique_15', '+'), ('unique_4', 'unique_28', 'cl'), ('unique_5', 'unique_28', '+'), ('unique_6', 'unique_13', 'default1'), ('unique_7', 'cl', '+'), ('unique_8', 'unique_6', 'cl'), ('unique_9', NULL, '+'), ('unique_10', 'unique_23', 'default1'), ('unique_11', 'unique_27', 'cl'), ('unique_12', 'unique_7', 'default1'), ('unique_13', 'default1', 'default2'), ('unique_14', 'unique_7', NULL), ('unique_15', 'unique_21', NULL), ('unique_16', 'default1', NULL), ('unique_17', 'default1', '+'), ('unique_18', 'unique_8', '+'), ('unique_19', NULL, 'cl'), ('unique_20', NULL, 'cl'), ('unique_21', 'unique_8', 'default2'), ('unique_22', 'unique_12', 'default1'), ('unique_23', 'unique_6', 'default2'), ('unique_24', 'default1', NULL), ('unique_25', 'unique_10', 'cl'), ('unique_26', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('unique_27',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Prediction Result:
('unique_27',)
('unique_27',)
*/