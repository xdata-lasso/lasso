-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '#', NULL), ('#', NULL, 'default1'), ('default1', '#', 'default2'), ('unique_3', '#', '#'), ('unique_4', NULL, NULL), ('unique_5', NULL, '#'), ('unique_6', NULL, '#'), ('unique_7', '#', 'default1'), ('unique_8', NULL, 'default2'), ('unique_9', '#', 'default1'), ('unique_10', NULL, NULL), ('unique_11', NULL, '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', NULL, '#'), ('default1', NULL, 'default1'), ('#', NULL, 'default2'), ('unique_3', '#', '#'), ('unique_4', '#', '#'), ('unique_5', NULL, '#'), ('unique_6', '#', NULL), ('unique_7', NULL, 'default2'), ('unique_8', '#', 'default1'), ('unique_9', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_5', 'default2', 'unique_5'), ('unique_8', '#', 'unique_7'), ('unique_6', 'unique_8', 'default1'), ('unique_8', 'unique_7', '#'), ('default2', '#', NULL), ('default2', 'default2', NULL), ('#', 'unique_6', 'unique_8'), ('unique_3', 'unique_4', 'unique_4'), ('unique_5', 'unique_4', 'unique_4'), ('unique_5', 'unique_6', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.element FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id WHERE T1.bond_type = '#';

/*
Gold Result:
('#',)
*/

-- Prediction Query
SELECT a.element FROM bond AS b JOIN connected AS c ON b.bond_id = c.bond_id JOIN atom AS a ON c.atom_id = a.atom_id WHERE b.bond_type = '#';

/*
Prediction Result:
('#',)
('#',)
*/