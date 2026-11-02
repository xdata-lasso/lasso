-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('default2', 'default1'), ('TR346', 'TR346'), ('unique_3', NULL), ('unique_4', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR346', 'unique_4', 'default2'), ('default1', 'unique_3', 'default1'), ('default2', 'TR346', 'default1'), ('unique_3', 'unique_3', 'TR346'), ('unique_4', 'TR346', 'TR346'), ('unique_5', 'unique_4', 'default1'), ('unique_6', 'TR346', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default1', 'TR346'), ('TR346', 'TR346', 'TR346'), ('default2', 'default2', NULL), ('unique_3', 'default1', 'default2'), ('unique_4', 'default2', NULL), ('unique_5', NULL, NULL), ('unique_6', 'unique_3', 'TR346');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('TR346', 0)
('TR346', 1)
('TR346', 1)
*/

-- Prediction Query
SELECT atom.atom_id, COUNT(DISTINCT bond.bond_type) FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id LEFT JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.molecule_id = 'TR346' GROUP BY atom.atom_id;

/*
Prediction Result:
('TR346', 2)
*/