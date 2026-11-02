-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', '45'), ('45', NULL), ('default1', '45'), ('unique_3', '45');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('45', '45', '45'), ('default2', 'default2', '45'), ('default1', 'default1', '45'), ('unique_3', 'default1', 'default1'), ('unique_4', NULL, NULL), ('unique_5', 'default1', 'default2'), ('unique_6', 'default1', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('45', NULL, NULL), ('default2', 'unique_3', NULL), ('default1', '45', 'default2'), ('unique_3', '45', '45');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('45', 'default2', 'unique_3'), ('45', '45', 'unique_6'), ('default1', 'unique_3', 'unique_4'), ('unique_3', 'default2', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE SUBSTRING(T2.atom_id, 7, 2) = '45';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.bond_type, T1.bond_id FROM bond AS T1 LEFT JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = '45';

/*
Prediction Result:
(None, 'unique_6')
('default1', 'unique_3')
*/