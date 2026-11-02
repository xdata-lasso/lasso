-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('#', '#'), ('default1', NULL), ('default2', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default1', NULL), ('#', '#', 'default1'), ('default1', 'default2', '#'), ('unique_3', NULL, 'default2'), ('unique_4', '#', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'default2'), ('default2', 'default1', NULL), ('#', 'default1', '#'), ('unique_3', '#', NULL), ('unique_4', '#', NULL), ('unique_5', '#', 'default1'), ('unique_6', NULL, NULL), ('unique_7', NULL, NULL), ('unique_8', NULL, 'default2'), ('unique_9', 'default1', NULL), ('unique_10', NULL, 'default1'), ('unique_11', '#', '#'), ('unique_12', 'default1', '#'), ('unique_13', 'default1', 'default1'), ('unique_14', 'default2', NULL), ('unique_15', '#', 'default1'), ('unique_16', 'default2', 'default2'), ('unique_17', NULL, 'default1'), ('unique_18', NULL, 'default1'), ('unique_19', 'default2', 'default1'), ('unique_20', 'default2', '#'), ('unique_21', 'default2', NULL), ('unique_22', 'default2', NULL), ('unique_23', '#', NULL), ('unique_24', 'default1', 'default2'), ('unique_25', 'default1', '#'), ('unique_26', 'default2', 'default2'), ('unique_27', '#', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id, T2.element FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '#';

/*
Gold Result:
('default2', None)
('default2', '#')
('default2', 'default1')
('default2', 'default2')
('#', None)
('#', '#')
('#', 'default1')
*/

-- Prediction Query
SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '#' ORDER BY T2.molecule_id, T1.element;

/*
Prediction Result:
('#', None)
('#', '#')
('#', 'default1')
('default2', None)
('default2', '#')
('default2', 'default1')
('default2', 'default2')
*/