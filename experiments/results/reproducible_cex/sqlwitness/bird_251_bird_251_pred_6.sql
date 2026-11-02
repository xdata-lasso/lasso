-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('+', '+'), ('default1', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', '+'), ('unique_14', 'default1'), ('unique_15', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_12', '+'), ('default1', 'unique_5', 'default2'), ('default2', 'unique_6', '+'), ('unique_3', '+', '+'), ('unique_4', 'unique_11', 'default2'), ('unique_5', 'unique_15', 'default1'), ('unique_6', NULL, '+'), ('unique_7', 'unique_3', '+'), ('unique_8', '+', NULL), ('unique_9', 'unique_3', 'default2'), ('unique_10', 'unique_7', 'default2'), ('unique_11', 'unique_7', '+'), ('unique_12', 'default2', 'default2'), ('unique_13', 'default1', 'default1'), ('unique_14', 'unique_8', '+'), ('unique_15', 'unique_4', '+'), ('unique_16', '+', 'default2'), ('unique_17', 'unique_5', '+'), ('unique_18', '+', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('+',)
*/

-- Prediction Query
SELECT atom.element FROM atom INNER JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+' GROUP BY atom.element ORDER BY COUNT(atom.element) ASC, atom.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/