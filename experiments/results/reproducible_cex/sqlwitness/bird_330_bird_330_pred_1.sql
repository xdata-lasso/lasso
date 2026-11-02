-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', '#'), ('+', 'default2'), ('default2', '+'), ('#', '+'), ('h', NULL), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', '+'), ('unique_9', 'default2'), ('unique_10', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('+', 'default1', '+'), ('#', 'unique_8', 'default2'), ('default1', 'unique_6', '+'), ('h', 'h', '+'), ('default2', NULL, '+'), ('unique_5', 'unique_5', 'default2'), ('unique_6', NULL, 'default1'), ('unique_7', 'default2', NULL), ('unique_8', NULL, 'h'), ('unique_9', 'default2', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default1', 'default2'), ('default1', 'default1', NULL), ('#', 'unique_5', 'h'), ('+', 'unique_10', 'h'), ('h', 'default2', NULL), ('unique_5', 'unique_9', 'default1'), ('unique_6', '#', 'default2'), ('unique_7', 'default2', NULL), ('unique_8', '+', '#'), ('unique_9', 'default2', NULL), ('unique_10', '#', 'default1'), ('unique_11', 'unique_8', 'default1'), ('unique_12', 'h', 'default2'), ('unique_13', 'default1', 'default2'), ('unique_14', 'unique_6', 'default2'), ('unique_15', 'unique_10', '+'), ('unique_16', 'unique_5', 'h');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_14', 'unique_11', 'unique_5'), ('unique_12', 'default1', 'unique_9'), ('default1', 'unique_7', 'unique_7'), ('+', 'unique_16', 'unique_9'), ('unique_13', 'unique_12', '+'), ('h', 'unique_5', 'h'), ('#', 'unique_7', 'unique_7'), ('unique_5', 'default1', 'unique_5'), ('unique_11', 'unique_5', '+'), ('default2', 'default2', 'default1'), ('+', 'unique_5', 'unique_8'), ('h', 'unique_7', 'unique_5'), ('unique_12', 'unique_16', NULL), ('unique_9', 'unique_8', 'default1'), ('unique_9', 'unique_15', 'default1'), ('h', 'unique_16', 'unique_8'), ('unique_16', 'unique_8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN m.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT a.molecule_id) AS percentage FROM atom AS a INNER JOIN connected AS c ON a.atom_id = c.atom_id INNER JOIN bond AS b ON c.bond_id = b.bond_id INNER JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE a.element = 'h' AND b.bond_type = '#';

/*
Prediction Result:
(100.0,)
*/