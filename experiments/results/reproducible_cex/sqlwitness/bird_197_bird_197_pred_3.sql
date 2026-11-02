-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'o'), ('o', '-'), ('-', '-'), ('default2', '-'), ('unique_4', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('o', '-', '-'), ('-', NULL, NULL), ('default1', '-', 'o'), ('default2', 'default1', 'o'), ('unique_4', 'o', NULL), ('unique_5', 'default1', NULL), ('unique_6', 'default2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'o'), ('o', 'default1', 'o'), ('-', 'default2', NULL), ('default2', '-', 'default1'), ('unique_4', 'default2', '-'), ('unique_5', 'o', 'default1'), ('unique_6', '-', NULL), ('unique_7', 'default1', 'o'), ('unique_8', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(oxygen_count) FROM (SELECT COUNT(CASE WHEN T2.element = 'o' THEN 1 ELSE NULL END) AS oxygen_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' GROUP BY T1.molecule_id);

/*
Prediction Result:
(0.0,)
*/