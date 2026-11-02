-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('TR024', 'default1'), ('=', 'TR024');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR024', '=', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'TR024'), ('default2', 'default2', NULL), ('TR024', 'default2', 'default2'), ('=', NULL, 'TR024'), ('unique_4', 'default2', NULL), ('unique_5', '=', 'default1'), ('unique_6', 'default2', '='), ('unique_7', NULL, 'default1'), ('unique_8', '=', 'default2'), ('unique_9', 'TR024', NULL), ('unique_10', '=', 'default2'), ('unique_11', 'default2', '='), ('unique_12', NULL, 'default2'), ('unique_13', NULL, 'default2'), ('unique_14', 'TR024', NULL), ('unique_15', NULL, '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_15', 'unique_11', 'TR024'), ('unique_9', 'default2', 'TR024'), ('unique_11', 'unique_10', NULL), ('default2', 'unique_14', 'TR024');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '=' AND T1.molecule_id = 'TR024' GROUP BY T1.element;

/*
Prediction Result:
(None,)
*/