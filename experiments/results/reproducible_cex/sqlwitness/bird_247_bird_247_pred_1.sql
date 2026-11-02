-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, 'default2'), ('default1', NULL, NULL), ('unique_2', NULL, 'default1'), ('unique_3', NULL, 'default1'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, 'default2'), ('unique_6', NULL, 'default2'), ('unique_7', NULL, NULL), ('unique_8', NULL, 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_8', 'default2'), ('unique_5', 'default2', NULL), ('unique_5', 'unique_5', 'default2'), ('unique_6', 'default1', 'default2'), ('unique_4', 'unique_4', NULL), ('unique_5', 'unique_2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE NOT T.element IN (SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id);

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT element FROM atom WHERE NOT atom_id IN (SELECT atom_id FROM connected UNION SELECT atom_id2 FROM connected);

/*
Prediction Result:
('default1',)
(None,)
*/