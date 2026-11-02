-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', 'cl'), ('default1', 'cl'), ('default2', '+'), ('cl', NULL), ('unique_4', '+'), ('unique_5', '+'), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', '+'), ('unique_9', 'default2'), ('unique_10', 'cl'), ('unique_11', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_9', 'default1'), ('default1', '+', '+'), ('cl', '+', 'cl'), ('+', 'unique_6', NULL), ('unique_4', 'cl', 'default2'), ('unique_5', 'unique_9', NULL), ('unique_6', 'unique_6', '+'), ('unique_7', 'default2', 'default1'), ('unique_8', 'unique_4', 'cl'), ('unique_9', 'unique_5', 'default1'), ('unique_10', 'unique_9', 'default1'), ('unique_11', 'unique_9', NULL), ('unique_12', 'unique_5', 'cl'), ('unique_13', 'unique_11', NULL), ('unique_14', 'unique_10', '+'), ('unique_15', 'unique_8', 'cl'), ('unique_16', 'unique_5', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Gold Result:
('unique_4',)
('unique_5',)
('unique_8',)
*/

-- Prediction Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'cl' AND T2.label = '+';

/*
Prediction Result:
('+',)
('+',)
('+',)
*/