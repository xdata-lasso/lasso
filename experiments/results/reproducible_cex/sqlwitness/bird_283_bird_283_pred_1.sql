-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('ca', 'default1'), ('default1', NULL), ('unique_3', 'default2'), ('unique_4', 'ca'), ('unique_5', 'default2'), ('unique_6', 'ca'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('ca', 'default2', 'ca'), ('default1', 'unique_4', 'default1'), ('default2', 'unique_5', 'default2'), ('unique_3', 'default2', 'ca'), ('unique_4', 'unique_4', 'ca'), ('unique_5', 'ca', 'default2'), ('unique_6', 'default1', 'default1'), ('unique_7', 'unique_5', 'ca'), ('unique_8', NULL, 'default1'), ('unique_9', NULL, NULL), ('unique_10', 'default1', NULL), ('unique_11', 'default2', 'default2'), ('unique_12', 'unique_5', 'default2'), ('unique_13', 'unique_10', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('default1',)
('default1',)
('ca',)
('default2',)
*/

-- Prediction Query
SELECT label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca');

/*
Prediction Result:
('default1',)
('ca',)
('default2',)
*/