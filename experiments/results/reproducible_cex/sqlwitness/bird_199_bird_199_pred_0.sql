-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', NULL), ('na', 'default1'), ('default2', '-'), ('default1', '-'), ('unique_4', 'na'), ('unique_5', '-'), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default2'), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default1'), ('unique_15', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_14', 'na'), ('default1', 'na', 'default2'), ('na', 'unique_12', '-'), ('-', 'unique_10', 'na'), ('unique_4', NULL, 'na'), ('unique_5', 'na', 'default1'), ('unique_6', 'default1', 'na'), ('unique_7', NULL, 'na'), ('unique_8', 'unique_11', 'default2'), ('unique_9', 'unique_15', NULL), ('unique_10', 'na', NULL), ('unique_11', 'unique_10', NULL), ('unique_12', 'unique_15', 'na'), ('unique_13', 'default1', '-'), ('unique_14', 'unique_15', 'na'), ('unique_15', 'unique_9', '-'), ('unique_16', 'unique_5', '-'), ('unique_17', 'unique_11', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Prediction Result:
(3,)
*/