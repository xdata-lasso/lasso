-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('default1', 'default1'), ('=', 'default1'), ('unique_3', '='), ('unique_4', '='), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', '='), ('unique_10', '='), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'default2'), ('unique_14', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', 'default2', 'default2'), ('default1', 'unique_10', '='), ('default2', 'unique_11', '='), ('unique_3', '=', '='), ('unique_4', 'unique_12', NULL), ('unique_5', 'unique_12', 'default2'), ('unique_6', 'unique_3', '='), ('unique_7', 'unique_5', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.label FROM molecule AS T1 INNER JOIN (SELECT T.molecule_id, COUNT(T.bond_type) FROM bond AS T WHERE T.bond_type = '=' GROUP BY T.molecule_id ORDER BY COUNT(T.bond_type) DESC, T.molecule_id NULLS LAST LIMIT 1) AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT m.label FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '=' GROUP BY m.molecule_id ORDER BY COUNT(b.bond_id) DESC, m.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('=',)
*/