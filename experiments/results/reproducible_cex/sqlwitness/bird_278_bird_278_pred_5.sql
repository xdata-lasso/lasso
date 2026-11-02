-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', 'default2'), ('default2', '-'), ('default1', '-'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', '-'), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', '-'), ('unique_9', '-'), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', 'default1'), ('unique_16', 'default2'), ('unique_17', '-'), ('unique_18', '-'), ('unique_19', '-'), ('unique_20', NULL), ('unique_21', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_4', NULL), ('-', 'unique_8', '-'), ('default1', 'unique_16', NULL), ('unique_3', 'unique_13', 'default2'), ('unique_4', 'default1', NULL), ('unique_5', 'unique_13', 'default2'), ('unique_6', 'unique_8', '-'), ('unique_7', '-', 'default1'), ('unique_8', 'unique_12', NULL), ('unique_9', 'default2', '-'), ('unique_10', 'unique_12', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '-' AND T1.bond_type = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T2.molecule_id) AS single_bond_count FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-';

/*
Prediction Result:
(3,)
*/