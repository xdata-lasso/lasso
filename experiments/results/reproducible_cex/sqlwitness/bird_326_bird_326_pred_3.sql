-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 's'), ('default2', 's'), ('s', '='), ('=', 'default2'), ('unique_4', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_4', 's'), ('s', 'default1', 'default1'), ('default1', 's', '='), ('=', NULL, NULL), ('unique_4', 'default2', 's'), ('unique_5', 'unique_4', '='), ('unique_6', 'default1', '='), ('unique_7', 'default2', 'default1'), ('unique_8', NULL, '='), ('unique_9', '=', 'default1'), ('unique_10', 'default2', 's'), ('unique_11', 's', 's');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('=', 'unique_4', 'default2'), ('s', NULL, NULL), ('default2', 's', '='), ('default1', 's', 's'), ('unique_4', 'default1', NULL), ('unique_5', 'unique_4', 'default2'), ('unique_6', '=', '='), ('unique_7', 'default2', 'default2'), ('unique_8', 'default2', '='), ('unique_9', 'unique_4', 'default2'), ('unique_10', 'default1', 's'), ('unique_11', NULL, 's'), ('unique_12', 's', 'default1'), ('unique_13', '=', 's');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'default1', 'unique_10'), ('default1', 'default1', '='), ('unique_10', 's', 'unique_7'), ('unique_10', 'unique_6', '='), ('unique_7', 'unique_7', 'unique_7'), ('unique_9', 'default1', 'unique_5'), ('unique_8', 'unique_12', NULL), ('unique_4', '=', 'unique_10'), ('s', 'default2', '='), ('=', 'default2', 'unique_8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
('s',)
('default1',)
*/

-- Prediction Query
SELECT T3.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '=' AND T3.element = 's';

/*
Prediction Result:
*/