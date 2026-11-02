-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'o'), ('-', 'default1'), ('default2', 'default1'), ('o', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', 'o'), ('unique_10', 'o'), ('unique_11', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_11', 'default1'), ('-', 'unique_5', 'o'), ('o', 'unique_11', 'default2'), ('default2', 'unique_8', 'o'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, NULL), ('unique_6', 'unique_8', '-'), ('unique_7', 'unique_6', NULL), ('unique_8', '-', NULL), ('unique_9', 'default2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_11', 'default1'), ('-', 'unique_6', NULL), ('default2', NULL, 'o'), ('o', NULL, NULL), ('unique_4', '-', '-'), ('unique_5', 'unique_7', 'o'), ('unique_6', 'o', 'default1'), ('unique_7', 'unique_5', 'default1'), ('unique_8', NULL, 'o'), ('unique_9', 'unique_10', 'default2'), ('unique_10', 'unique_10', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_8', 'default2', 'unique_6'), ('default1', 'unique_5', NULL), ('o', 'o', 'unique_5'), ('default2', 'default2', 'unique_4'), ('unique_4', 'unique_8', 'unique_6'), ('unique_7', 'unique_10', 'default1'), ('unique_9', 'unique_10', 'o'), ('unique_9', '-', 'unique_6'), ('-', 'unique_4', 'unique_4'), ('default1', 'unique_9', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(CASE WHEN atom.element = 'o' THEN 1.0 ELSE 0 END) AS avg_oxygen_atoms FROM bond INNER JOIN connected ON bond.bond_id = connected.bond_id INNER JOIN atom ON connected.atom_id = atom.atom_id WHERE bond.bond_type = '-';

/*
Prediction Result:
(0.3333333333333333,)
*/