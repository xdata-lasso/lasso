-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('TR346', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'TR346', 'default1'), ('default2', 'default2', NULL), ('TR346', 'default2', NULL), ('unique_3', NULL, 'TR346'), ('unique_4', 'default2', NULL), ('unique_5', 'TR346', NULL), ('unique_6', 'default2', 'default1'), ('unique_7', 'default2', 'default2'), ('unique_8', 'TR346', 'TR346'), ('unique_9', 'default2', 'default1'), ('unique_10', NULL, 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'TR346', 'default2'), ('default1', NULL, NULL), ('TR346', NULL, 'default2'), ('unique_3', 'default2', NULL), ('unique_4', 'default2', 'default2'), ('unique_5', 'TR346', NULL), ('unique_6', NULL, 'TR346'), ('unique_7', 'default2', 'default2'), ('unique_8', 'TR346', 'default2'), ('unique_9', NULL, 'default1'), ('unique_10', NULL, NULL), ('unique_11', NULL, NULL), ('unique_12', 'TR346', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('default2', 0)
('default2', 1)
('default2', 1)
('unique_12', 0)
('unique_12', 1)
('unique_12', 1)
('unique_5', 0)
('unique_5', 1)
('unique_5', 1)
('unique_8', 0)
('unique_8', 1)
('unique_8', 1)
*/

-- Prediction Query
SELECT atom.atom_id, COUNT(DISTINCT bond.bond_type) AS bond_count FROM bond INNER JOIN atom ON bond.molecule_id = atom.molecule_id WHERE bond.molecule_id = 'TR346' GROUP BY atom.atom_id;

/*
Prediction Result:
('default2', 2)
('unique_12', 2)
('unique_5', 2)
('unique_8', 2)
*/