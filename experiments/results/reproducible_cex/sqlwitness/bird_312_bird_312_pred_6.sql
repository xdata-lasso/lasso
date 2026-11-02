-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('default2', NULL), ('TR001_2_4', NULL), ('unique_3', 'TR001_2_4');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default1', 'default2'), ('TR001_2_4', 'TR001_2_4', 'TR001_2_4'), ('default2', NULL, NULL), ('unique_3', 'default1', 'default2'), ('unique_4', 'unique_3', 'default1'), ('unique_5', 'unique_3', NULL), ('unique_6', 'TR001_2_4', 'TR001_2_4'), ('unique_7', 'default2', 'default2'), ('unique_8', NULL, 'default2'), ('unique_9', NULL, 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_3', 'TR001_2_4'), ('default2', 'unique_3', 'TR001_2_4'), ('TR001_2_4', 'default1', 'default2'), ('unique_3', 'default1', 'default1'), ('unique_4', 'unique_3', NULL), ('unique_5', 'default1', 'TR001_2_4'), ('unique_6', 'unique_3', 'TR001_2_4'), ('unique_7', NULL, 'default2'), ('unique_8', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_id = 'TR001_2_4';

/*
Gold Result:
*/

-- Prediction Query
SELECT m.label FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE b.bond_id = 'TR001_2_4';

/*
Prediction Result:
(None,)
*/