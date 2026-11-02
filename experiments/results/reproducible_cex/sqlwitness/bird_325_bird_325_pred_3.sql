-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', '+'), ('n', 'default2'), ('+', 'n'), ('default1', 'n'), ('unique_4', '+'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'n'), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', '+'), ('unique_13', NULL), ('unique_14', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('n', 'unique_6', 'n'), ('default2', 'n', 'default1'), ('default1', 'default2', 'default2'), ('+', 'unique_14', NULL), ('unique_4', 'unique_5', '+'), ('unique_5', 'unique_13', 'default2'), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_5', NULL), ('unique_8', NULL, 'n'), ('unique_9', 'unique_14', 'default2'), ('unique_10', 'unique_4', 'default1'), ('unique_11', 'unique_4', 'n'), ('unique_12', NULL, 'default2'), ('unique_13', 'unique_4', 'n'), ('unique_14', 'unique_11', 'default2'), ('unique_15', 'unique_4', 'default2'), ('unique_16', 'n', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'n' AND T1.label = '+';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE atom.element = 'n' AND molecule.label = '+';

/*
Prediction Result:
(2,)
*/