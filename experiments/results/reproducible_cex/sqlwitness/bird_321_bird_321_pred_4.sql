-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'TR000_2'), ('default1', 'default1'), ('TR000_2', 'TR000_2'), ('TR000_4', 'default1'), ('unique_4', 'default2'), ('unique_5', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR000_4', NULL, 'default2'), ('TR000_2', NULL, 'default1'), ('default2', 'TR000_4', 'TR000_2'), ('default1', 'default2', 'TR000_4'), ('unique_4', 'TR000_4', 'TR000_4'), ('unique_5', 'TR000_2', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_4', 'default1'), ('TR000_4', 'default2', 'TR000_2'), ('TR000_2', NULL, 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'TR000_2', 'default1'), ('TR000_2', 'default1', 'unique_5'), ('default1', 'TR000_4', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.atom_id = 'TR000_2' UNION SELECT T1.molecule_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id2 WHERE T2.atom_id2 = 'TR000_4';

/*
Prediction Result:
(None,)
('default2',)
*/