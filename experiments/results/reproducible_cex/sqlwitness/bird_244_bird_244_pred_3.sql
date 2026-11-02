-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('=', 'default2'), ('default1', 'default1'), ('default2', 'default1'), ('unique_3', 'default1'), ('unique_4', '='), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', '='), ('unique_13', '='), ('unique_14', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_13', NULL), ('=', 'unique_3', '='), ('default1', 'unique_9', '='), ('unique_3', 'unique_4', NULL), ('unique_4', '=', '='), ('unique_5', 'unique_13', 'default2'), ('unique_6', 'unique_12', 'default2'), ('unique_7', NULL, '='), ('unique_8', 'unique_14', NULL), ('unique_9', 'unique_3', NULL), ('unique_10', 'unique_8', 'default1'), ('unique_11', 'unique_3', NULL), ('unique_12', 'unique_14', '='), ('unique_13', 'unique_6', '='), ('unique_14', 'unique_12', 'default2'), ('unique_15', 'unique_4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' GROUP BY T2.molecule_id ORDER BY COUNT(T1.bond_type) DESC, T2.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/