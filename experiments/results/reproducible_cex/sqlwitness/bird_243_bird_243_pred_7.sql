-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'p'), ('n', 'default2'), ('p', 'default1'), ('default2', 'n'), ('unique_4', NULL), ('unique_5', 'n'), ('unique_6', NULL), ('unique_7', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'unique_5', 'default1'), ('default2', 'unique_4', NULL), ('p', 'unique_4', 'p'), ('n', 'unique_4', 'p'), ('unique_4', 'default2', 'default2'), ('unique_5', 'default1', 'p'), ('unique_6', 'default1', 'p'), ('unique_7', 'unique_6', 'n'), ('unique_8', NULL, 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('p', 'n', 'p'), ('default2', 'n', 'default1'), ('n', 'unique_6', 'default1'), ('default1', 'unique_5', 'default1'), ('unique_4', 'unique_6', 'n'), ('unique_5', 'unique_5', 'default2'), ('unique_6', 'default1', 'default2'), ('unique_7', 'default1', 'n'), ('unique_8', 'n', 'n');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'default1', 'default2'), ('default2', 'p', NULL), ('p', 'n', 'n'), ('unique_8', 'p', 'unique_4'), ('default1', 'unique_4', 'default2'), ('p', 'unique_5', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('unique_4',)
*/

-- Prediction Query
SELECT DISTINCT c.bond_id FROM connected AS c INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE a1.element = 'p' AND a2.element = 'n';

/*
Prediction Result:
*/