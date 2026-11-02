-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('p', 'default1'), ('default2', 'default1'), ('n', 'n'), ('default1', NULL), ('unique_4', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'n', NULL), ('default1', 'unique_4', 'default1'), ('p', 'default2', 'default2'), ('n', 'n', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default2', 'p'), ('default1', 'n', 'default2'), ('p', NULL, 'default1'), ('n', 'p', 'n'), ('unique_4', 'default2', 'default2'), ('unique_5', NULL, 'p'), ('unique_6', 'unique_4', 'n'), ('unique_7', 'default1', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_4', 'default2', 'n'), ('unique_5', 'unique_4', 'default2'), ('unique_6', 'unique_6', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT bond.bond_id FROM atom AS atom1 INNER JOIN connected AS connected1 ON atom1.atom_id = connected1.atom_id INNER JOIN bond ON connected1.bond_id = bond.bond_id WHERE atom1.element = 'p' AND connected1.atom_id2 IN (SELECT atom2.atom_id FROM atom AS atom2 WHERE atom2.element = 'n');

/*
Prediction Result:
*/