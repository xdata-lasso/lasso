-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', NULL, NULL), ('br', NULL, NULL), ('#', NULL, 'p'), ('p', NULL, 'default1'), ('default2', NULL, 'p'), ('unique_5', NULL, '#'), ('unique_6', NULL, 'default1'), ('unique_7', NULL, 'p'), ('unique_8', NULL, 'br'), ('unique_9', NULL, '#'), ('unique_10', NULL, NULL), ('unique_11', NULL, 'p'), ('unique_12', NULL, 'default1'), ('unique_13', NULL, 'br'), ('unique_14', NULL, 'br'), ('unique_15', NULL, 'default2'), ('unique_16', NULL, NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('p', NULL, 'default2'), ('default2', NULL, 'p'), ('br', NULL, 'p'), ('default1', NULL, 'default1'), ('#', NULL, NULL), ('unique_5', NULL, 'default1'), ('unique_6', NULL, 'br'), ('unique_7', NULL, 'p'), ('unique_8', NULL, 'default2'), ('unique_9', NULL, '#'), ('unique_10', NULL, NULL), ('unique_11', NULL, 'br');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'default1', 'unique_7'), ('#', 'unique_7', '#'), ('br', 'default2', 'p'), ('unique_6', '#', 'unique_16'), ('#', 'unique_6', 'default2'), ('unique_6', 'default2', 'br'), ('p', 'p', 'default1'), ('unique_9', 'br', 'unique_5'), ('br', 'unique_9', 'unique_13'), ('br', '#', 'unique_5'), ('unique_5', 'default2', 'unique_5'), ('default2', 'default2', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element IN ('p', 'br');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT a.atom_id) FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '#' AND a.element IN ('p', 'br');

/*
Prediction Result:
(1,)
*/