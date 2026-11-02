-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('default1', 'default1'), ('TR001_10_11', 'TR001_10_11'), ('unique_3', 'TR001_10_11');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_3', 'TR001_10_11'), ('default2', 'unique_3', 'default2'), ('TR001_10_11', 'default1', 'TR001_10_11'), ('unique_3', 'default1', NULL), ('unique_4', 'default2', NULL), ('unique_5', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'default1'), ('TR001_10_11', 'default2', 'default1'), ('default2', 'TR001_10_11', 'default1'), ('unique_3', 'unique_3', NULL), ('unique_4', 'TR001_10_11', 'default2'), ('unique_5', NULL, NULL), ('unique_6', 'default2', NULL), ('unique_7', 'default1', NULL), ('unique_8', 'default1', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'unique_7', 'default2'), ('default1', 'unique_7', 'TR001_10_11'), ('unique_4', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR001_10_11';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT a1.element, a2.element FROM connected AS c JOIN atom AS a1 ON c.atom_id = a1.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE c.bond_id = 'TR001_10_11';

/*
Prediction Result:
('default1', None)
*/