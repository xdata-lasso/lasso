-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('h', 'h'), ('#', NULL), ('default1', 'default1'), ('+', 'default1'), ('default2', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('h', '+', 'h'), ('default1', '+', 'default1'), ('#', 'default1', NULL), ('default2', 'default1', NULL), ('+', '+', 'h'), ('unique_5', 'default1', 'default1'), ('unique_6', 'default1', 'h'), ('unique_7', '+', NULL), ('unique_8', 'h', 'default2'), ('unique_9', 'default1', '#'), ('unique_10', 'h', 'default2'), ('unique_11', '#', 'default1'), ('unique_12', NULL, 'h'), ('unique_13', '+', 'h'), ('unique_14', 'default1', 'default2'), ('unique_15', NULL, NULL), ('unique_16', 'default2', NULL), ('unique_17', NULL, '+'), ('unique_18', '#', 'default1'), ('unique_19', 'default1', '+'), ('unique_20', 'h', 'default1'), ('unique_21', NULL, '#'), ('unique_22', 'h', 'h'), ('unique_23', 'default1', '+'), ('unique_24', 'default1', 'h'), ('unique_25', 'default2', '+'), ('unique_26', NULL, '#'), ('unique_27', 'default2', '+'), ('unique_28', 'default2', 'h'), ('unique_29', 'default1', NULL), ('unique_30', '#', NULL), ('unique_31', 'default2', '#'), ('unique_32', NULL, 'h'), ('unique_33', 'default2', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('#', '+', 'h'), ('default1', '+', NULL), ('+', '+', '#'), ('default2', 'h', 'default1'), ('h', 'default1', 'h'), ('unique_5', '+', '+'), ('unique_6', '#', '+'), ('unique_7', 'h', '+'), ('unique_8', '+', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'h', 'unique_24'), ('#', 'h', 'default1'), ('unique_7', '+', 'default1'), ('unique_7', 'unique_7', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id INNER JOIN connected AS T4 ON T3.bond_id = T4.bond_id WHERE T2.element = 'h' AND T3.bond_type = '#';

/*
Prediction Result:
(None,)
*/