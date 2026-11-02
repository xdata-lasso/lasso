-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('default2', 'TR001_1'), ('Yes', NULL), ('+', 'No'), ('TR001_1', 'default1'), ('No', 'TR001_1'), ('unique_6', 'TR001_1'), ('unique_7', 'default2'), ('unique_8', 'No');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('No', 'No', 'Yes'), ('TR001_1', 'TR001_1', 'No'), ('+', 'unique_8', 'No'), ('default1', 'default1', 'TR001_1'), ('default2', 'unique_7', 'default2'), ('Yes', 'unique_8', 'default1'), ('unique_6', 'unique_7', NULL), ('unique_7', '+', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.atom_id = 'TR001_1';

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CASE WHEN T1.label = '+' THEN 'Yes' ELSE 'No' END AS Is_Carcinogenic FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.atom_id = 'TR001_1';

/*
Prediction Result:
('No',)
*/