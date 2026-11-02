-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('sn', 'default2'), ('default1', 'default1'), ('default2', NULL), ('unique_3', 'sn'), ('unique_4', 'default2'), ('unique_5', 'sn'), ('unique_6', 'default1'), ('unique_7', 'sn'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', 'sn'), ('unique_13', 'default2'), ('unique_14', 'sn'), ('unique_15', 'sn');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'default1'), ('sn', 'default2', 'sn'), ('default2', 'unique_12', 'default1'), ('unique_3', 'unique_3', NULL), ('unique_4', 'unique_11', 'default2'), ('unique_5', 'unique_11', 'sn'), ('unique_6', 'unique_8', 'sn'), ('unique_7', 'unique_11', 'default1'), ('unique_8', 'unique_4', 'sn'), ('unique_9', 'unique_8', 'default1'), ('unique_10', 'default2', 'default2'), ('unique_11', 'unique_13', 'sn');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
('sn',)
('default2',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Prediction Result:
('sn',)
('default2',)
('default2',)
('default1',)
(None,)
*/