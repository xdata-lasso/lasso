-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M_BOND', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M_ATOM1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('M_ATOM2', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_2', 'M_ATOM1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_4', 'M_ATOM2', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M_BOND', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_2', 'TR000_4', 'B1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.molecule_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR000_2' AND T2.atom_id2 = 'TR000_4';

/*
Gold Result:
('M_BOND',)
*/

-- Prediction Query
SELECT atom.molecule_id FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.atom_id = 'TR000_2' AND connected.atom_id2 = 'TR000_4';

/*
Prediction Result:
('M_ATOM1',)
*/