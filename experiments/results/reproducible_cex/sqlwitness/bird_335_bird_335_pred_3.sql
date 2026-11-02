-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('o', 'default2'), ('=', 'o'), ('default2', 'o'), ('default1', NULL), ('unique_4', 'default2'), ('unique_5', '='), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('o', '=', '='), ('=', NULL, '='), ('default1', 'o', '='), ('default2', '=', 'o'), ('unique_4', 'default2', 'default2'), ('unique_5', 'unique_9', '='), ('unique_6', 'unique_6', NULL), ('unique_7', 'unique_4', '='), ('unique_8', 'default1', 'default1'), ('unique_9', '=', 'o'), ('unique_10', 'unique_9', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('o', 'default2', 'o'), ('default1', 'o', 'default1'), ('=', 'unique_4', NULL), ('default2', 'default1', '='), ('unique_4', 'unique_7', 'default2'), ('unique_5', 'o', NULL), ('unique_6', '=', 'o'), ('unique_7', 'unique_9', 'default2'), ('unique_8', 'unique_9', 'default1'), ('unique_9', 'unique_4', 'default2'), ('unique_10', 'unique_9', NULL), ('unique_11', 'default2', 'o'), ('unique_12', NULL, '='), ('unique_13', '=', 'o'), ('unique_14', 'unique_9', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', 'unique_8', 'unique_9'), ('unique_6', 'unique_11', 'default1'), ('unique_11', 'unique_14', 'unique_5'), ('unique_6', '=', NULL), ('unique_4', 'unique_14', 'default1'), ('unique_13', 'unique_12', 'unique_10'), ('unique_8', 'default2', NULL), ('unique_4', 'unique_6', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=' AND T1.element = 'o';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.molecule_id) FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a1 ON c.atom_id = a1.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE (a1.element = 'o' OR a2.element = 'o') AND b.bond_type = '=';

/*
Prediction Result:
(2,)
*/