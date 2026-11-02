-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('sn', 'sn');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'sn', 'sn');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('sn', 'sn', 'sn'), ('default1', NULL, 'default2'), ('default2', 'sn', NULL), ('unique_3', NULL, 'sn'), ('unique_4', NULL, NULL), ('unique_5', 'sn', 'default2'), ('unique_6', NULL, 'sn'), ('unique_7', 'sn', 'default2'), ('unique_8', NULL, 'sn'), ('unique_9', NULL, 'sn'), ('unique_10', NULL, 'sn'), ('unique_11', NULL, 'sn');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('sn', 'unique_10', NULL), ('unique_11', 'unique_7', 'default2'), ('unique_6', 'sn', 'default2'), ('unique_11', 'sn', 'default2'), ('unique_11', 'unique_4', NULL), ('unique_6', 'unique_10', NULL), ('unique_10', 'sn', 'default2'), ('unique_9', 'sn', 'default2'), ('unique_3', 'unique_10', NULL), ('unique_10', 'default2', 'default2'), ('unique_3', 'unique_7', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('sn',)
*/

-- Prediction Query
SELECT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T1.element = 'sn';

/*
Prediction Result:
('sn',)
('sn',)
('sn',)
('sn',)
('sn',)
('sn',)
('sn',)
*/