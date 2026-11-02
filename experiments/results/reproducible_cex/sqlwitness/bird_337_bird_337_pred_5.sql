-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('default1', 'default1'), ('TR016', NULL), ('TR002', 'TR016');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR002', 'default1', 'TR016'), ('TR016', 'TR016', 'TR002'), ('default1', 'TR002', 'default1'), ('default2', 'default2', 'TR002'), ('unique_4', 'default1', 'TR002'), ('unique_5', 'default2', 'TR002');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default1', 'TR002'), ('TR002', 'TR002', 'default2'), ('TR016', 'TR016', 'default1'), ('default1', 'default1', 'default2'), ('unique_4', 'TR016', 'TR016'), ('unique_5', 'default1', 'TR016'), ('unique_6', 'TR002', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element, T2.bond_type FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR016';

/*
Gold Result:
('default1', 'TR002')
('TR016', 'TR002')
*/

-- Prediction Query
SELECT atom.element, bond.bond_type FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.molecule_id = 'TR002';

/*
Prediction Result:
('default2', 'default1')
('default2', 'default1')
*/