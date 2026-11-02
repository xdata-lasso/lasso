-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('default2', NULL), ('unique_2', NULL), ('unique_3', 'default1'), ('unique_4', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'unique_3', 'default2'), ('default1', 'unique_2', 'default2'), ('unique_2', NULL, 'default2'), ('unique_3', 'default2', 'default2'), ('unique_4', 'unique_3', 'default1'), ('unique_5', 'default1', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_2', 'default1'), ('default2', 'unique_3', 'default2'), ('unique_2', 'unique_3', 'default1'), ('unique_3', 'unique_4', NULL), ('unique_4', 'unique_3', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_2', 'unique_2', 'unique_3'), ('unique_3', 'unique_4', 'unique_2'), ('default1', 'unique_4', 'unique_5'), ('unique_2', 'default2', NULL), ('unique_4', 'default2', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE NOT T.element IN (SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 EXCEPT SELECT T2.element FROM atom AS T2 INNER JOIN connected AS T3 ON T2.atom_id = T3.atom_id;

/*
Prediction Result:
('default2',)
*/