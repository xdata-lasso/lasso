-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('h', 'default1'), ('+', 'default2'), ('#', 'default2'), ('default1', '#'), ('default2', 'default1'), ('unique_5', 'h'), ('unique_6', 'h'), ('unique_7', '#'), ('unique_8', '+'), ('unique_9', '+'), ('unique_10', 'default2'), ('unique_11', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('#', 'unique_11', '+'), ('default1', 'unique_11', 'h'), ('h', 'unique_6', 'h'), ('+', 'unique_10', '#'), ('default2', 'default1', 'h'), ('unique_5', '#', 'default2'), ('unique_6', 'unique_10', 'default1'), ('unique_7', '#', 'default1'), ('unique_8', '#', '+'), ('unique_9', 'unique_6', '+'), ('unique_10', 'unique_9', '+'), ('unique_11', 'unique_11', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('+', 'default1', '+'), ('#', NULL, '+'), ('h', 'h', 'default2'), ('default1', NULL, 'h'), ('default2', 'unique_10', 'h'), ('unique_5', 'default1', '#'), ('unique_6', 'default1', 'default1'), ('unique_7', '#', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_5', 'unique_7'), ('#', 'h', 'h'), ('default2', 'default1', 'h'), ('unique_7', 'unique_6', NULL), ('+', 'default2', '+'), ('h', 'unique_5', 'unique_8'), ('+', 'unique_5', '+'), ('unique_7', 'default2', 'unique_9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) AS percentage FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T2.atom_id = T3.atom_id INNER JOIN bond AS T4 ON T3.bond_id = T4.bond_id WHERE T2.element = 'h' AND T4.bond_type = '#';

/*
Prediction Result:
(None,)
*/