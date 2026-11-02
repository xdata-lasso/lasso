-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('ca', 'ca'), ('default1', 'default1'), ('default2', 'ca'), ('unique_3', 'default1'), ('unique_4', 'ca'), ('unique_5', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('ca', 'unique_3', 'ca'), ('default2', NULL, 'default2'), ('default1', NULL, 'ca'), ('unique_3', 'default2', 'default2'), ('unique_4', 'unique_5', 'default1'), ('unique_5', 'unique_5', 'ca'), ('unique_6', 'unique_4', 'default2'), ('unique_7', 'unique_3', 'ca'), ('unique_8', 'unique_4', 'ca'), ('unique_9', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
('default1',)
(None,)
('default1',)
('ca',)
*/

-- Prediction Query
SELECT DISTINCT m.label FROM atom AS a JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE a.element = 'ca';

/*
Prediction Result:
('default1',)
(None,)
('ca',)
*/