-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('te', 'default1'), ('default1', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('te', NULL, 'te'), ('default2', NULL, 'c'), ('c', 'te', 'default2'), ('default1', 'default1', 'default1'), ('unique_4', 'te', 'te'), ('unique_5', 'default1', 'default2'), ('unique_6', 'te', 'te'), ('unique_7', 'te', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'default1'), ('c', 'te', 'te'), ('te', NULL, 'default2'), ('default1', 'te', NULL), ('unique_4', NULL, 'c'), ('unique_5', NULL, 'c'), ('unique_6', 'default1', 'te'), ('unique_7', NULL, 'default2'), ('unique_8', 'te', 'te'), ('unique_9', 'default1', 'default2'), ('unique_10', 'default1', NULL), ('unique_11', 'te', NULL), ('unique_12', 'te', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
('c',)
('default2',)
('te',)
('default1',)
*/

-- Prediction Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c';

/*
Prediction Result:
*/