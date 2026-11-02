-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', NULL), ('default2', NULL), ('default1', 'default2'), ('n', 'default1'), ('unique_4', NULL), ('unique_5', '+'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', '+'), ('unique_9', '+'), ('unique_10', 'default1'), ('unique_11', '+'), ('unique_12', '+'), ('unique_13', NULL), ('unique_14', '+'), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', '+'), ('unique_19', 'default1'), ('unique_20', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_13', 'default1'), ('+', 'unique_5', 'default2'), ('n', 'unique_16', 'n'), ('default2', 'unique_14', 'n'), ('unique_4', '+', '+'), ('unique_5', 'unique_15', 'default1'), ('unique_6', 'unique_19', 'default1'), ('unique_7', 'unique_13', NULL), ('unique_8', 'n', 'default1'), ('unique_9', 'unique_12', 'n'), ('unique_10', 'default1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_20', NULL), ('n', 'unique_16', '+'), ('default2', 'unique_4', 'n'), ('+', 'unique_7', 'default2'), ('unique_4', NULL, NULL), ('unique_5', 'unique_15', 'default1'), ('unique_6', 'unique_6', '+'), ('unique_7', 'unique_6', 'n'), ('unique_8', 'unique_19', '+'), ('unique_9', 'unique_11', 'n'), ('unique_10', 'unique_18', NULL), ('unique_11', 'unique_13', NULL), ('unique_12', 'unique_15', 'default2'), ('unique_13', 'unique_11', 'default2'), ('unique_14', 'unique_11', '+'), ('unique_15', 'unique_8', 'default1'), ('unique_16', 'unique_10', NULL), ('unique_17', 'unique_14', 'default2'), ('unique_18', 'unique_11', NULL), ('unique_19', '+', 'n'), ('unique_20', 'unique_10', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_4', 'unique_12', 'unique_10'), ('unique_7', 'unique_13', 'default2'), ('unique_19', 'unique_9', 'n'), ('unique_12', 'unique_12', 'unique_9'), ('unique_4', 'unique_15', 'default1'), ('default1', 'unique_20', 'default1'), ('unique_13', 'unique_13', 'default2'), ('unique_15', '+', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'n' AND T1.label = '+';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id JOIN connected AS c ON a.atom_id = c.atom_id WHERE m.label = '+' AND a.element = 'n';

/*
Prediction Result:
(0,)
*/