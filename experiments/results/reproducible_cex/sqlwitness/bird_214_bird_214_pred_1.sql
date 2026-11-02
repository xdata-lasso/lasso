-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('sn', NULL), ('default1', NULL), ('default2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'default2'), ('sn', 'sn', NULL), ('default1', 'sn', 'default1'), ('unique_3', 'unique_3', 'default1'), ('unique_4', 'unique_4', 'default2'), ('unique_5', NULL, 'sn'), ('unique_6', 'default1', NULL), ('unique_7', 'default1', 'sn'), ('unique_8', 'unique_3', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 'sn';

/*
Gold Result:
(None,)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT label FROM molecule WHERE NOT molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'sn');

/*
Prediction Result:
*/