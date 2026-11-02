-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('te', 'te'), ('default1', NULL), ('default2', 'te'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'te'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'te'), ('unique_9', NULL), ('unique_10', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('te', 'unique_4', 'default1'), ('default2', NULL, 'default2'), ('default1', 'te', 'te'), ('unique_3', 'unique_3', 'default1'), ('unique_4', 'unique_9', 'default2'), ('unique_5', 'unique_8', 'default2'), ('unique_6', 'unique_3', 'default1'), ('unique_7', 'unique_9', 'default1'), ('unique_8', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'default1'), ('default1', 'unique_3', 'default1'), ('te', 'unique_9', 'default2'), ('unique_3', 'unique_3', 'default2'), ('unique_4', 'unique_7', 'default2'), ('unique_5', NULL, 'default1'), ('unique_6', NULL, 'te'), ('unique_7', 'te', NULL), ('unique_8', NULL, 'te'), ('unique_9', 'unique_7', 'default2'), ('unique_10', 'unique_3', 'default2'), ('unique_11', 'unique_10', NULL), ('unique_12', 'unique_4', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_11', 'unique_9', 'unique_8'), ('unique_8', 'default1', 'unique_7'), ('unique_10', 'unique_10', 'unique_5'), ('default2', 'unique_8', 'unique_6'), ('unique_10', 'unique_8', 'unique_8'), ('unique_7', 'unique_10', 'unique_7'), ('unique_7', 'te', 'te'), ('unique_7', 'unique_12', 'te'), ('unique_8', 'unique_4', NULL), ('unique_8', 'unique_3', 'default2'), ('unique_11', 'unique_12', 'te'), ('unique_3', 'unique_10', 'te');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'te';

/*
Prediction Result:
('default1',)
('default2',)
*/