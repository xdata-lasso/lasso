-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000', NULL, 'default2'), ('default1', NULL, 'TR000'), ('default2', NULL, NULL), ('unique_3', 'TR000', NULL), ('unique_4', NULL, 'default2'), ('unique_5', NULL, NULL), ('unique_6', 'TR000', 'default2'), ('unique_7', 'TR000', 'default1'), ('unique_8', NULL, NULL), ('unique_9', NULL, 'default1'), ('unique_10', 'TR000', 'default1'), ('unique_11', 'TR000', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.bond_type FROM bond AS T WHERE T.molecule_id = 'TR000';

/*
Gold Result:
(None,)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT T2.bond_type FROM molecule AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR000';

/*
Prediction Result:
(None,)
('default2',)
('default1',)
('default1',)
('default1',)
*/