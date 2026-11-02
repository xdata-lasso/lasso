-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('br', 'default1'), ('+', '+'), ('default2', 'default1'), ('default1', 'default1'), ('unique_4', '+'), ('unique_5', 'br'), ('unique_6', '+'), ('unique_7', '+'), ('unique_8', '+'), ('unique_9', 'br'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', '+'), ('unique_13', 'default2'), ('unique_14', '+'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', '+'), ('unique_18', 'default1'), ('unique_19', 'default1'), ('unique_20', 'default1'), ('unique_21', 'default1'), ('unique_22', '+'), ('unique_23', 'default2'), ('unique_24', 'default2'), ('unique_25', '+'), ('unique_26', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_4', 'br'), ('default2', 'unique_24', NULL), ('default1', 'unique_15', 'default2'), ('br', 'unique_19', '+'), ('unique_4', 'default1', NULL), ('unique_5', '+', NULL), ('unique_6', 'unique_24', 'default1'), ('unique_7', 'unique_18', '+'), ('unique_8', 'unique_22', 'default1'), ('unique_9', 'unique_19', 'default2'), ('unique_10', 'unique_5', 'br'), ('unique_11', 'unique_22', 'default1'), ('unique_12', '+', 'default1'), ('unique_13', 'unique_22', 'default2'), ('unique_14', 'unique_9', NULL), ('unique_15', 'unique_11', 'default1'), ('unique_16', 'unique_7', NULL), ('unique_17', 'unique_22', NULL), ('unique_18', 'unique_12', 'br'), ('unique_19', 'unique_25', NULL), ('unique_20', 'unique_12', 'br'), ('unique_21', 'unique_4', 'br'), ('unique_22', 'unique_21', 'default1'), ('unique_23', 'default1', 'default1'), ('unique_24', 'unique_12', 'default1'), ('unique_25', NULL, '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND T1.element = 'br';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' AND T2.element = 'br';

/*
Prediction Result:
(4,)
*/