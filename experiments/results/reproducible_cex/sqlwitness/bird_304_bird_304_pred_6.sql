-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('+', '+'), ('default1', '+'), ('default2', '+'), ('unique_3', '+'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', '+'), ('unique_8', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'unique_5', 'default2'), ('default2', 'unique_6', 'default1'), ('default1', 'unique_4', 'default2'), ('unique_3', 'default1', '+'), ('unique_4', 'unique_3', 'default2'), ('unique_5', 'unique_8', '+'), ('unique_6', 'default2', 'default1'), ('unique_7', NULL, NULL), ('unique_8', 'unique_4', '+'), ('unique_9', '+', NULL), ('unique_10', 'unique_3', 'default1'), ('unique_11', 'unique_3', 'default2'), ('unique_12', 'unique_5', NULL), ('unique_13', 'unique_3', '+'), ('unique_14', '+', '+'), ('unique_15', '+', '+'), ('unique_16', 'default1', '+'), ('unique_17', 'unique_6', '+'), ('unique_18', 'unique_5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
('default1', '+')
('unique_3', 'default2')
('unique_8', '+')
('default2', 'default1')
('+', None)
('unique_3', 'default1')
('unique_3', '+')
('+', '+')
*/

-- Prediction Query
SELECT m.molecule_id, a.element FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+';

/*
Prediction Result:
('default1', '+')
('unique_3', 'default2')
('unique_8', '+')
('default2', 'default1')
('+', None)
('unique_3', 'default1')
('unique_3', 'default2')
('unique_3', '+')
('+', '+')
('+', '+')
('default1', '+')
*/