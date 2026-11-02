-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('cl', '-'), ('default2', '-'), ('-', 'default1'), ('default1', 'default1'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', '-'), ('unique_7', '-'), ('unique_8', 'default1'), ('unique_9', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', 'unique_5', NULL), ('default2', 'unique_5', 'default2'), ('cl', 'unique_4', NULL), ('default1', '-', 'cl'), ('unique_4', 'default2', 'default1'), ('unique_5', 'cl', 'default2'), ('unique_6', 'unique_5', NULL), ('unique_7', 'unique_6', 'cl'), ('unique_8', 'default1', 'default2'), ('unique_9', 'default2', 'default1'), ('unique_10', 'unique_7', 'cl'), ('unique_11', 'cl', 'default2'), ('unique_12', 'default2', '-'), ('unique_13', 'unique_8', 'cl'), ('unique_14', 'unique_8', NULL), ('unique_15', '-', 'default2'), ('unique_16', 'unique_9', NULL), ('unique_17', 'unique_6', 'cl'), ('unique_18', '-', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'cl' AND T1.label = '-';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '-' AND a.element = 'cl';

/*
Prediction Result:
(3,)
*/