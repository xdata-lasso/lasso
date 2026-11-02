-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('TR018', 'default1'), ('default2', NULL), ('unique_3', NULL), ('unique_4', 'TR018');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default1', 'TR018'), ('default1', 'TR018', 'default1'), ('TR018', 'default2', NULL), ('unique_3', 'unique_4', NULL), ('unique_4', 'TR018', NULL), ('unique_5', 'default2', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_3', 'TR018'), ('default1', 'TR018', 'TR018'), ('TR018', 'default2', 'default1'), ('unique_3', NULL, 'TR018'), ('unique_4', 'unique_3', NULL), ('unique_5', 'unique_3', 'TR018'), ('unique_6', 'unique_3', 'TR018'), ('unique_7', 'default1', 'TR018'), ('unique_8', 'unique_4', NULL), ('unique_9', 'unique_4', 'TR018');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_4', 'unique_6', 'unique_5'), ('default1', 'default2', 'default2'), ('unique_6', 'unique_4', 'unique_3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.bond_type, T3.label FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST, T3.label NULLS LAST LIMIT 1;

/*
Prediction Result:
*/