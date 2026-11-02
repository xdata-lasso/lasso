-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('default2', 'default1'), ('TR186', 'default2'), ('unique_3', 'TR186'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_8', 'default2'), ('default2', 'unique_5', 'default1'), ('TR186', 'default2', NULL), ('unique_3', 'unique_5', NULL), ('unique_4', 'unique_3', 'default1'), ('unique_5', 'TR186', 'default1'), ('unique_6', 'unique_8', 'default2'), ('unique_7', 'unique_7', 'TR186'), ('unique_8', 'unique_5', 'TR186'), ('unique_9', NULL, 'TR186'), ('unique_10', NULL, 'default2'), ('unique_11', 'unique_7', 'TR186');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id = 'TR186';

/*
Gold Result:
('unique_5',)
*/

-- Prediction Query
SELECT T1.atom_id, T1.element FROM atom AS T1 WHERE T1.molecule_id = 'TR186';

/*
Prediction Result:
('unique_5', 'default1')
*/