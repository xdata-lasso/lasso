-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('TR016', NULL), ('default1', 'TR016'), ('unique_3', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR016', 'TR016', 'TR016'), ('default2', NULL, NULL), ('default1', 'TR016', 'default2'), ('unique_3', 'default1', 'default2'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default1', 'default2'), ('default1', NULL, NULL), ('TR016', 'unique_3', 'default2'), ('unique_3', 'default2', 'TR016'), ('unique_4', NULL, NULL), ('unique_5', 'unique_3', NULL), ('unique_6', 'default2', 'TR016'), ('unique_7', 'default2', 'TR016'), ('unique_8', 'unique_3', 'default2'), ('unique_9', NULL, 'default2'), ('unique_10', 'TR016', 'default2'), ('unique_11', 'unique_3', 'TR016'), ('unique_12', 'TR016', 'default1'), ('unique_13', NULL, 'TR016'), ('unique_14', NULL, 'default1'), ('unique_15', 'TR016', 'default1'), ('unique_16', 'unique_3', 'TR016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('default2', 'TR016')
('default2', 'default2')
('default1', 'TR016')
('default1', 'default2')
*/

-- Prediction Query
SELECT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Prediction Result:
('default2', 'TR016')
('default2', 'default2')
('default1', 'TR016')
('default1', 'default2')
('default1', 'TR016')
('default1', 'default2')
*/