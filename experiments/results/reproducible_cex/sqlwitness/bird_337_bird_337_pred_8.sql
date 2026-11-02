-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'TR016'), ('TR002', 'TR002'), ('TR016', 'TR016'), ('default2', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'TR002'), ('unique_10', 'default2'), ('unique_11', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_8', 'TR002'), ('default1', 'unique_5', NULL), ('TR016', 'unique_11', 'TR002'), ('TR002', 'unique_4', 'TR002'), ('unique_4', 'TR016', 'TR002'), ('unique_5', 'unique_10', 'default1'), ('unique_6', 'default1', 'default1'), ('unique_7', 'unique_7', 'default2'), ('unique_8', 'unique_6', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR002', 'TR002', 'default1'), ('TR016', 'unique_7', 'default2'), ('default1', 'unique_8', 'TR002'), ('default2', 'unique_5', 'default1'), ('unique_4', 'unique_9', 'default1'), ('unique_5', 'unique_5', 'TR002'), ('unique_6', 'unique_7', 'default2'), ('unique_7', 'unique_7', 'default1'), ('unique_8', 'TR002', 'TR016');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'default1', 'unique_6'), ('unique_6', 'default1', 'default1'), ('unique_6', 'unique_8', 'unique_6'), ('unique_6', 'unique_6', NULL), ('unique_8', 'unique_7', 'TR002'), ('default2', 'default1', NULL), ('default2', 'unique_5', 'default1'), ('unique_5', 'TR002', 'TR002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT a.element, b.bond_type FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.molecule_id = 'TR002';

/*
Prediction Result:
('TR016', 'default1')
('TR016', 'TR002')
*/