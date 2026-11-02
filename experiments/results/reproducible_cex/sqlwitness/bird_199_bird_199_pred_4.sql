-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('na', NULL), ('-', '-'), ('default2', 'na'), ('unique_4', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default1', 'default2'), ('-', 'unique_4', 'default1'), ('default2', '-', 'default1'), ('na', 'na', 'na'), ('unique_4', NULL, 'default1'), ('unique_5', 'na', NULL), ('unique_6', 'unique_4', '-'), ('unique_7', 'unique_4', 'default1'), ('unique_8', '-', 'na'), ('unique_9', 'default2', 'na'), ('unique_10', 'default1', 'default1'), ('unique_11', '-', 'default1'), ('unique_12', '-', '-'), ('unique_13', '-', 'na'), ('unique_14', 'na', 'na'), ('unique_15', NULL, '-'), ('unique_16', '-', 'default2'), ('unique_17', 'unique_4', NULL), ('unique_18', 'default1', 'default2'), ('unique_19', '-', 'na'), ('unique_20', NULL, 'default1'), ('unique_21', 'default1', 'default1'), ('unique_22', 'default2', 'na'), ('unique_23', NULL, NULL), ('unique_24', NULL, 'default1'), ('unique_25', '-', NULL), ('unique_26', 'unique_4', '-'), ('unique_27', 'na', 'na'), ('unique_28', 'unique_4', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'na' AND T2.label = '-';

/*
Prediction Result:
(3,)
*/