-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'TR346'), ('TR346', 'default2'), ('default1', 'TR346'), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default2', 'default1'), ('default2', 'default2', 'default1'), ('TR346', 'default1', NULL), ('unique_3', 'TR346', 'default2'), ('unique_4', 'unique_5', NULL), ('unique_5', NULL, NULL), ('unique_6', 'unique_3', 'default2'), ('unique_7', 'unique_5', NULL), ('unique_8', 'TR346', 'default1'), ('unique_9', 'TR346', 'TR346'), ('unique_10', 'unique_5', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'TR346', NULL), ('TR346', 'default2', 'default2'), ('default2', 'unique_3', 'TR346'), ('unique_3', 'unique_5', 'default1'), ('unique_4', 'default2', 'default1'), ('unique_5', 'unique_5', 'default1'), ('unique_6', 'default2', 'default2'), ('unique_7', 'default2', 'default2'), ('unique_8', NULL, 'default2'), ('unique_9', 'unique_3', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('default1', 1)
('default1', 1)
('default1', 1)
*/

-- Prediction Query
SELECT T1.atom_id, COUNT(T3.bond_type) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.label = 'TR346' GROUP BY T1.atom_id;

/*
Prediction Result:
('TR346', 2)
('unique_4', 2)
('unique_6', 2)
('unique_7', 2)
*/