-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'o'), ('default1', 'default2'), ('o', '='), ('=', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'o'), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', '='), ('unique_10', 'o'), ('unique_11', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default1'), ('o', 'unique_7', 'default1'), ('=', 'unique_11', 'default2'), ('default1', 'unique_4', 'o'), ('unique_4', 'unique_7', '='), ('unique_5', 'unique_5', NULL), ('unique_6', 'unique_7', NULL), ('unique_7', 'unique_11', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, NULL), ('default2', 'default2', 'o'), ('o', 'unique_10', '='), ('=', 'unique_11', NULL), ('unique_4', '=', 'default2'), ('unique_5', 'unique_11', 'default1'), ('unique_6', '=', 'default2'), ('unique_7', 'o', '='), ('unique_8', NULL, NULL), ('unique_9', 'unique_7', 'o'), ('unique_10', 'unique_11', 'default2'), ('unique_11', 'unique_5', NULL), ('unique_12', 'default2', 'default2'), ('unique_13', 'unique_10', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_13', 'unique_8', 'unique_5'), ('unique_12', 'default2', '='), ('unique_4', '=', 'default1'), ('unique_8', 'unique_10', 'unique_5'), ('unique_6', 'unique_4', 'unique_7'), ('unique_8', 'unique_8', 'default2'), ('unique_12', 'unique_12', 'unique_5'), ('unique_12', 'unique_11', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id OR T1.atom_id = T2.atom_id2 INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'o' AND T3.bond_type = '=' AND T1.molecule_id = T3.molecule_id;

/*
Prediction Result:
(0,)
*/