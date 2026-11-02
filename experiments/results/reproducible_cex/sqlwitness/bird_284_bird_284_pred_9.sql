-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('te', 'default1'), ('default2', 'default2'), ('c', 'c'), ('unique_4', 'te'), ('unique_5', 'default1'), ('unique_6', 'te'), ('unique_7', 'default2'), ('unique_8', 'c'), ('unique_9', 'te');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_6', 'te'), ('te', 'default2', 'c'), ('c', 'default1', 'default2'), ('default1', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('te', NULL, 'te'), ('c', 'c', 'default2'), ('default2', 'unique_9', 'default2'), ('default1', NULL, 'te'), ('unique_4', 'unique_6', 'c'), ('unique_5', 'unique_5', 'default1'), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_8', 'default1'), ('unique_8', 'default2', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', 'c', 'te'), ('default2', 'unique_8', NULL), ('unique_4', 'c', 'default1'), ('unique_8', 'default2', 'te'), ('c', 'default2', 'te'), ('te', 'default2', NULL), ('default2', 'unique_5', NULL), ('unique_4', 'unique_4', 'c'), ('unique_8', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'c';

/*
Prediction Result:
(None,)
('default2',)
*/