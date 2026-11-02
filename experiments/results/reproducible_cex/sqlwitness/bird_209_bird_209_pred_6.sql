-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('te', 'te');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'te', NULL), ('cl', NULL, 'default2'), ('default2', NULL, 'cl'), ('te', 'te', 'default2'), ('unique_4', 'te', 'cl'), ('unique_5', NULL, 'default2'), ('unique_6', NULL, 'te'), ('unique_7', 'te', NULL), ('unique_8', 'default2', NULL), ('unique_9', 'te', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('te', 'te', 'default1'), ('cl', 'te', 'cl');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('te', 'te', 'cl'), ('cl', 'cl', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T3.element = 'te';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id OR atom.atom_id = connected.atom_id2 INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'cl';

/*
Prediction Result:
('cl',)
*/