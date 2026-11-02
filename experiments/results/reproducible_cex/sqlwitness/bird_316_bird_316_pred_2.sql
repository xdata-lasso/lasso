-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('-', '-'), ('default1', 'default2'), ('c', 'c'), ('unique_4', 'c'), ('unique_5', 'default2'), ('unique_6', '-'), ('unique_7', 'default2'), ('unique_8', 'c'), ('unique_9', 'default1'), ('unique_10', 'c'), ('unique_11', 'c'), ('unique_12', '-'), ('unique_13', 'default2'), ('unique_14', NULL), ('unique_15', '-'), ('unique_16', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_8', 'c'), ('-', NULL, 'default1'), ('c', 'unique_14', NULL), ('default2', 'default1', NULL), ('unique_4', 'unique_7', 'default2'), ('unique_5', 'unique_10', 'default2'), ('unique_6', '-', '-'), ('unique_7', NULL, 'c'), ('unique_8', '-', 'default2'), ('unique_9', 'unique_9', 'default1'), ('unique_10', 'default2', 'c'), ('unique_11', 'unique_11', 'default2'), ('unique_12', 'unique_14', NULL), ('unique_13', 'unique_9', '-'), ('unique_14', 'default1', 'default2'), ('unique_15', 'unique_6', 'c'), ('unique_16', 'unique_12', 'default1'), ('unique_17', NULL, 'default1'), ('unique_18', 'unique_6', 'default2'), ('unique_19', 'unique_6', 'c'), ('unique_20', 'unique_8', 'default1'), ('unique_21', 'unique_6', 'c'), ('unique_22', 'unique_12', NULL), ('unique_23', '-', 'default1'), ('unique_24', 'default1', NULL), ('unique_25', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('unique_6',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Prediction Result:
('unique_6',)
('unique_6',)
('unique_6',)
*/