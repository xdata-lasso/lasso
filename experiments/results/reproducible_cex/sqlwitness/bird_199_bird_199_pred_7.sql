-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('na', 'na'), ('default1', 'default2'), ('-', '-'), ('default2', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', '-'), ('unique_9', NULL), ('unique_10', '-'), ('unique_11', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_6', '-'), ('default2', '-', 'na'), ('na', 'unique_6', NULL), ('-', 'unique_9', 'default1'), ('unique_4', 'unique_8', 'na'), ('unique_5', '-', 'na'), ('unique_6', 'default1', 'na'), ('unique_7', 'na', 'default2'), ('unique_8', 'unique_6', 'default2'), ('unique_9', 'unique_11', 'default1'), ('unique_10', 'unique_9', 'default1'), ('unique_11', 'unique_9', 'default1'), ('unique_12', 'na', 'default2'), ('unique_13', 'unique_10', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '-' AND T2.element = 'na';

/*
Prediction Result:
(3,)
*/