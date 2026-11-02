-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', 'c'), ('default2', 'TR010'), ('default1', NULL), ('TR050', NULL), ('c', 'default1'), ('unique_5', 'c'), ('unique_6', NULL), ('unique_7', 'TR050'), ('unique_8', 'TR050'), ('unique_9', 'TR010'), ('unique_10', NULL), ('unique_11', 'c'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', NULL), ('unique_18', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'TR010', 'TR050'), ('TR050', 'unique_17', 'c'), ('default2', 'unique_8', 'TR010'), ('TR010', 'unique_13', 'TR050'), ('c', 'c', 'c'), ('unique_5', 'default2', 'default2'), ('unique_6', 'TR050', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
('unique_6',)
*/

-- Prediction Query
SELECT atom_id FROM atom WHERE element = 'c' AND SUBSTRING(molecule_id, 3, 3) BETWEEN 10 AND 50;

/*
Prediction Result:
*/