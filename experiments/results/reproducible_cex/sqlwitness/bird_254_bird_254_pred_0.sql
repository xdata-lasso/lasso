-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, NULL), ('default1', NULL, 'default1'), ('unique_2', NULL, 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, NULL), ('default2', NULL, 'default2'), ('unique_2', NULL, 'default1'), ('unique_3', NULL, NULL), ('unique_4', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_4', 'default2'), ('unique_2', 'default1', NULL), ('unique_2', 'unique_2', 'default2'), ('unique_4', 'unique_3', 'default1'), ('unique_4', 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(60.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.bond_id) AS REAL) * 100 / (SELECT COUNT(T2.atom_id) FROM (SELECT atom_id, COUNT(atom_id) AS atom_count FROM connected GROUP BY atom_id ORDER BY atom_count DESC, atom_id NULLS LAST LIMIT 1) AS T2) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id;

/*
Prediction Result:
(400.0,)
*/