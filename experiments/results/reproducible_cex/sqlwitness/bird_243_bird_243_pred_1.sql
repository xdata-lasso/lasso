-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('p', 'default1'), ('n', 'p'), ('default1', 'n'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'p'), ('unique_10', 'n'), ('unique_11', NULL), ('unique_12', 'n'), ('unique_13', 'p'), ('unique_14', 'default2'), ('unique_15', 'p'), ('unique_16', 'default2'), ('unique_17', 'n'), ('unique_18', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('p', 'unique_9', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'p', 'p'), ('p', 'unique_15', 'default1'), ('n', 'unique_4', 'default2'), ('default1', 'unique_9', 'n'), ('unique_4', 'unique_16', 'n'), ('unique_5', 'unique_16', 'default2'), ('unique_6', 'default2', 'n'), ('unique_7', 'unique_8', NULL), ('unique_8', 'unique_14', 'n'), ('unique_9', 'unique_12', 'default2'), ('unique_10', NULL, 'default1'), ('unique_11', 'n', NULL), ('unique_12', 'unique_5', NULL), ('unique_13', 'unique_8', 'p'), ('unique_14', 'unique_18', NULL), ('unique_15', 'default2', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_9', 'unique_7', 'p'), ('unique_6', 'unique_4', NULL), ('unique_15', 'unique_4', NULL), ('default2', 'unique_8', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
*/

-- Prediction Query
SELECT c.bond_id FROM connected AS c INNER JOIN atom AS a1 ON c.atom_id = a1.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE (a1.element = 'p' AND a2.element = 'n') OR (a1.element = 'n' AND a2.element = 'p');

/*
Prediction Result:
('p',)
*/