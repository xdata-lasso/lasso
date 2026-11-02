-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', 'default1'), ('default2', NULL), ('default1', NULL), ('unique_3', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_3', 'default2'), ('#', '#', '#'), ('default1', 'default1', 'default1'), ('unique_3', NULL, NULL), ('unique_4', 'default2', NULL), ('unique_5', NULL, 'default1'), ('unique_6', NULL, NULL), ('unique_7', '#', 'default1'), ('unique_8', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', '#', NULL), ('#', 'default2', 'default1'), ('default2', '#', '#'), ('unique_3', 'default1', '#'), ('unique_4', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('#', None)
('#', '#')
*/

-- Prediction Query
SELECT b.molecule_id, GROUP_CONCAT(DISTINCT a.element) AS elements FROM bond AS b INNER JOIN atom AS a ON b.molecule_id = a.molecule_id WHERE b.bond_type = '#' GROUP BY b.molecule_id;

/*
Prediction Result:
('#', '#')
*/