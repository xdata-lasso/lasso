-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('+', NULL), ('br', '+'), ('default1', 'default2'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', '+'), ('unique_7', 'br'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', '+'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', '+'), ('unique_14', NULL), ('unique_15', '+'), ('unique_16', '+'), ('unique_17', '+'), ('unique_18', 'br'), ('unique_19', '+'), ('unique_20', 'default2'), ('unique_21', NULL), ('unique_22', 'br'), ('unique_23', NULL), ('unique_24', NULL), ('unique_25', 'default1'), ('unique_26', '+'), ('unique_27', 'default2'), ('unique_28', 'br'), ('unique_29', 'default2'), ('unique_30', '+'), ('unique_31', '+'), ('unique_32', 'br');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('br', 'unique_6', 'default1'), ('default1', 'unique_22', NULL), ('+', 'br', 'default2'), ('default2', 'unique_31', '+'), ('unique_4', 'unique_29', '+'), ('unique_5', 'unique_26', 'br'), ('unique_6', 'unique_28', NULL), ('unique_7', 'unique_31', 'br'), ('unique_8', 'unique_16', NULL), ('unique_9', 'unique_4', '+'), ('unique_10', 'unique_8', '+'), ('unique_11', 'unique_8', NULL), ('unique_12', 'unique_26', 'default1'), ('unique_13', 'unique_32', 'default1'), ('unique_14', NULL, 'default2'), ('unique_15', 'unique_25', 'default2'), ('unique_16', 'unique_31', 'default1'), ('unique_17', 'default1', 'default1'), ('unique_18', 'unique_18', 'br'), ('unique_19', 'unique_15', 'br'), ('unique_20', 'unique_11', 'br'), ('unique_21', 'unique_16', 'br'), ('unique_22', 'unique_5', '+'), ('unique_23', 'unique_13', 'br'), ('unique_24', 'unique_15', 'br'), ('unique_25', 'unique_32', 'default2'), ('unique_26', 'br', 'br'), ('unique_27', 'unique_17', '+'), ('unique_28', 'unique_7', 'default2'), ('unique_29', 'unique_17', '+'), ('unique_30', 'br', '+'), ('unique_31', 'unique_32', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'br';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' AND T2.element = 'br';

/*
Prediction Result:
(7,)
*/