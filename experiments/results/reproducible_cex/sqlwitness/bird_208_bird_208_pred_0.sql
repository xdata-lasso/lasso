-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('default2', 'default1'), ('h', NULL), ('unique_3', 'h'), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', 'h'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', 'default2'), ('unique_16', NULL), ('unique_17', 'h'), ('unique_18', 'default1'), ('unique_19', 'default2'), ('unique_20', 'default2'), ('unique_21', NULL), ('unique_22', 'h'), ('unique_23', 'h'), ('unique_24', 'default1'), ('unique_25', NULL), ('unique_26', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('h', 'unique_14', NULL), ('default2', 'unique_15', 'default2'), ('default1', 'unique_22', 'default2'), ('unique_3', 'unique_9', NULL), ('unique_4', 'unique_11', 'h'), ('unique_5', 'default1', 'default1'), ('unique_6', 'default2', 'default1'), ('unique_7', 'unique_9', 'default1'), ('unique_8', 'unique_6', 'default1'), ('unique_9', 'unique_26', 'default2'), ('unique_10', 'unique_18', 'default1'), ('unique_11', 'unique_14', 'default2'), ('unique_12', 'unique_19', 'default1'), ('unique_13', 'h', 'default2'), ('unique_14', 'unique_9', 'default2'), ('unique_15', 'unique_16', NULL), ('unique_16', 'unique_26', NULL), ('unique_17', 'unique_10', 'default2'), ('unique_18', 'unique_10', 'default1'), ('unique_19', 'unique_7', 'h'), ('unique_20', 'unique_24', 'default1'), ('unique_21', 'unique_7', 'default1'), ('unique_22', 'unique_15', NULL), ('unique_23', 'unique_23', 'h'), ('unique_24', 'unique_16', NULL), ('unique_25', 'default1', 'h'), ('unique_26', 'unique_22', 'default2'), ('unique_27', 'unique_5', 'default1'), ('unique_28', 'unique_26', 'default1'), ('unique_29', 'unique_22', NULL), ('unique_30', 'unique_25', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.label FROM (SELECT T2.label, COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'h' GROUP BY T2.label ORDER BY COUNT(T2.molecule_id) DESC, T2.label NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'h' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/