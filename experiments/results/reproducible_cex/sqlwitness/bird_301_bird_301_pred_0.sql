-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('TR007_4_19', NULL), ('default2', 'default2'), ('unique_3', 'TR007_4_19'), ('unique_4', 'TR007_4_19'), ('unique_5', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR007_4_19', 'unique_3', NULL), ('default2', 'unique_3', 'default1'), ('default1', 'unique_4', 'TR007_4_19');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR007_4_19', 'unique_5', NULL), ('default2', 'unique_5', 'TR007_4_19'), ('default1', 'unique_3', 'TR007_4_19');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR007_4_19', 'default1', 'default2'), ('TR007_4_19', 'TR007_4_19', 'default2'), ('default1', 'TR007_4_19', 'TR007_4_19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM bond AS T WHERE T.bond_id = 'TR007_4_19';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T2.bond_type FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T1.atom_id = 'TR007_4_19' OR T1.atom_id2 = 'TR007_4_19';

/*
Prediction Result:
('default1',)
('default1',)
(None,)
*/