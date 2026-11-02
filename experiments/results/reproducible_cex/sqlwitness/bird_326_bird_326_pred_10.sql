-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', NULL, '='), ('s', NULL, 'default2'), ('default2', NULL, 'default2'), ('default1', NULL, 'default2'), ('unique_4', NULL, 's'), ('unique_5', NULL, 'default1'), ('unique_6', NULL, 's'), ('unique_7', NULL, 'default1'), ('unique_8', NULL, '='), ('unique_9', NULL, 'default1'), ('unique_10', NULL, 'default2'), ('unique_11', NULL, '='), ('unique_12', NULL, '='), ('unique_13', NULL, 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, '='), ('s', NULL, 'default2'), ('=', NULL, 's'), ('default2', NULL, 's'), ('unique_4', NULL, 's');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('s', 'default1', 'unique_12'), ('default1', 'unique_4', 'unique_12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id2 INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 's' AND T3.bond_type = '=';

/*
Prediction Result:
(None,)
*/