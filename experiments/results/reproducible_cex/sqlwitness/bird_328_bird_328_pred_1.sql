-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR024', 'TR024'), ('default1', 'TR024'), ('default2', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default1', 'default2'), ('TR024', 'default1', '='), ('=', 'default1', 'default2'), ('default2', 'TR024', '='), ('unique_4', NULL, 'default2'), ('unique_5', 'default1', 'default2'), ('unique_6', NULL, 'TR024'), ('unique_7', 'default1', 'default1'), ('unique_8', NULL, 'default2'), ('unique_9', 'TR024', 'TR024'), ('unique_10', 'default2', 'default1'), ('unique_11', 'TR024', 'default2'), ('unique_12', 'default2', 'TR024'), ('unique_13', 'TR024', 'TR024'), ('unique_14', 'default1', NULL), ('unique_15', NULL, 'TR024'), ('unique_16', NULL, 'TR024'), ('unique_17', 'TR024', '='), ('unique_18', 'default2', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'default2'), ('=', 'TR024', 'TR024'), ('TR024', 'default1', 'default1'), ('default2', NULL, '='), ('unique_4', NULL, 'default1'), ('unique_5', 'TR024', 'TR024'), ('unique_6', 'TR024', 'TR024'), ('unique_7', 'default2', '='), ('unique_8', NULL, 'TR024');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'default1', 'default1'), ('unique_5', 'TR024', 'unique_4'), ('unique_8', '=', 'unique_13'), ('default1', '=', 'unique_5'), ('unique_7', 'default2', 'unique_9'), ('unique_8', 'default1', 'unique_18'), ('unique_6', 'default1', 'unique_16'), ('default2', 'default1', 'default2'), ('unique_7', 'default1', 'unique_14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
('TR024',)
('TR024',)
('TR024',)
('TR024',)
('TR024',)
('TR024',)
*/

-- Prediction Query
SELECT DISTINCT a1.element FROM atom AS a1 INNER JOIN connected AS c ON a1.atom_id = c.atom_id INNER JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '=' AND b.molecule_id = 'TR024' UNION SELECT DISTINCT a2.element FROM atom AS a2 INNER JOIN connected AS c ON a2.atom_id = c.atom_id2 INNER JOIN bond AS b ON b.bond_id = c.bond_id WHERE b.bond_type = '=' AND b.molecule_id = 'TR024';

/*
Prediction Result:
('=',)
('default2',)
*/