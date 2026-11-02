-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('n', NULL), ('p', 'p'), ('default2', NULL), ('unique_4', 'default2'), ('unique_5', 'n'), ('unique_6', 'default2'), ('unique_7', 'n'), ('unique_8', 'n'), ('unique_9', 'default1'), ('unique_10', 'n'), ('unique_11', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('p', 'unique_6', NULL), ('default1', 'unique_10', 'p'), ('n', 'default1', 'default2'), ('default2', 'unique_11', 'default2'), ('unique_4', 'unique_7', NULL), ('unique_5', 'n', 'p'), ('unique_6', 'unique_8', 'n'), ('unique_7', 'default1', 'n'), ('unique_8', 'unique_9', 'n'), ('unique_9', 'unique_9', 'default2'), ('unique_10', 'default2', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('p', 'default1', 'p'), ('default1', 'unique_6', 'n'), ('default2', 'unique_7', NULL), ('n', 'unique_9', 'default2'), ('unique_4', 'n', 'p'), ('unique_5', 'unique_9', 'p'), ('unique_6', 'unique_4', 'p');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_4', NULL), ('default1', 'default2', 'unique_9'), ('unique_5', 'default2', 'unique_4'), ('unique_4', 'default2', 'unique_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('unique_9',)
*/

-- Prediction Query
SELECT T1.bond_id FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id INNER JOIN atom AS T3 ON T1.atom_id2 = T3.atom_id WHERE T2.element = 'p' AND T3.element = 'n';

/*
Prediction Result:
*/