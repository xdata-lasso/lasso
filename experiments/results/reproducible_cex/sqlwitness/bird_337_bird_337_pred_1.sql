-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR016', NULL), ('default1', 'default2'), ('TR002', 'TR002'), ('default2', 'default2'), ('unique_4', 'TR002'), ('unique_5', 'TR016');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR016', 'default1', 'default1'), ('default2', 'default1', 'TR016'), ('TR002', 'unique_5', NULL), ('default1', NULL, NULL), ('unique_4', 'TR016', NULL), ('unique_5', 'default1', 'default1'), ('unique_6', 'TR002', 'default2'), ('unique_7', 'default1', 'default2'), ('unique_8', 'default1', 'default1'), ('unique_9', NULL, 'default1'), ('unique_10', 'unique_5', 'default2'), ('unique_11', 'TR016', 'default2'), ('unique_12', NULL, 'TR016');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'TR002', 'TR016'), ('default2', 'default1', 'TR016'), ('TR002', 'TR016', 'TR002'), ('TR016', 'default2', NULL), ('unique_4', 'TR016', 'default1'), ('unique_5', NULL, NULL), ('unique_6', 'default2', NULL), ('unique_7', 'TR016', NULL), ('unique_8', 'default1', 'default2'), ('unique_9', 'default2', NULL), ('unique_10', 'default2', 'default2'), ('unique_11', 'TR002', 'TR002');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('TR002', None)
('TR002', 'default2')
('default1', None)
('default1', 'default2')
(None, None)
(None, 'default2')
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM atom INNER JOIN bond ON atom.molecule_id = bond.molecule_id WHERE atom.molecule_id = 'TR002';

/*
Prediction Result:
('TR016', 'default2')
('TR002', 'default2')
*/