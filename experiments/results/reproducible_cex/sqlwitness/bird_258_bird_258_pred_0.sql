-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('default1', 'sn'), ('sn', 'sn'), ('unique_3', 'default1'), ('unique_4', 'sn'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_7', 'default1'), ('sn', 'unique_3', 'sn');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('sn', 'unique_4', 'default1'), ('default1', 'unique_7', 'default1'), ('default2', 'unique_5', 'sn'), ('unique_3', 'unique_5', NULL), ('unique_4', 'unique_6', NULL), ('unique_5', 'sn', 'default2'), ('unique_6', 'default2', 'default1'), ('unique_7', 'unique_4', 'default2'), ('unique_8', 'unique_6', 'default1'), ('unique_9', 'sn', NULL), ('unique_10', 'default2', 'sn'), ('unique_11', 'sn', 'sn'), ('unique_12', 'default2', 'default2'), ('unique_13', 'sn', 'sn'), ('unique_14', 'unique_6', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_11', 'unique_3', NULL), ('unique_6', 'unique_13', NULL), ('unique_10', 'unique_9', 'sn'), ('unique_10', 'unique_10', 'sn'), ('unique_7', 'unique_4', NULL), ('sn', 'default2', 'sn'), ('unique_4', 'sn', 'sn'), ('unique_7', 'unique_12', NULL), ('unique_5', 'unique_12', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.bond_type FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T3.bond_id = T2.bond_id WHERE T1.element = 'sn';

/*
Gold Result:
('sn',)
*/

-- Prediction Query
SELECT bond.bond_type FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'sn';

/*
Prediction Result:
('sn',)
('sn',)
*/