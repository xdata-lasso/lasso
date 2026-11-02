-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('c', 'default2'), ('-', 'default2'), ('default2', 'default2'), ('default1', '-'), ('unique_4', 'c'), ('unique_5', 'c'), ('unique_6', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('c', 'default2', NULL), ('-', 'unique_6', 'c'), ('default1', 'default2', NULL), ('default2', 'unique_5', 'c'), ('unique_4', 'default2', 'default1'), ('unique_5', 'default1', 'default2'), ('unique_6', 'unique_6', 'c'), ('unique_7', 'default1', '-'), ('unique_8', 'default2', 'default1'), ('unique_9', '-', 'default2'), ('unique_10', NULL, '-'), ('unique_11', 'default2', 'default2'), ('unique_12', 'unique_6', 'default2'), ('unique_13', 'unique_5', 'default1'), ('unique_14', 'unique_6', 'default2'), ('unique_15', 'default2', 'default2'), ('unique_16', 'c', 'default1'), ('unique_17', 'unique_6', 'c'), ('unique_18', 'default2', 'default2'), ('unique_19', 'default1', '-'), ('unique_20', 'unique_4', 'c'), ('unique_21', 'default1', NULL), ('unique_22', NULL, '-'), ('unique_23', NULL, '-'), ('unique_24', 'unique_4', 'default2'), ('unique_25', 'default2', NULL), ('unique_26', 'unique_5', 'c'), ('unique_27', 'default2', 'default1'), ('unique_28', 'unique_6', 'c'), ('unique_29', 'c', '-'), ('unique_30', '-', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('unique_6',)
*/

-- Prediction Query
SELECT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c' AND T1.label = '-';

/*
Prediction Result:
('unique_6',)
('unique_6',)
('unique_6',)
('unique_6',)
*/