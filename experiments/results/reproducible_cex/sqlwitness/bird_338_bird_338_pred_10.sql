-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default2'), ('=', 'default1'), ('c', 'default2'), ('TR012', 'default2'), ('default1', 'default2'), ('unique_5', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('c', 'c', '='), ('default2', 'default2', 'default2'), ('=', '=', 'TR012'), ('default1', 'unique_5', 'default1'), ('TR012', 'c', NULL), ('unique_5', 'TR012', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR012', 'c', 'c');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR012', 'TR012', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T2.molecule_id = 'TR012' AND T3.bond_type = '=' AND T1.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.atom_id FROM (SELECT atom_id, atom_id2 FROM connected WHERE bond_id IN (SELECT bond_id FROM bond WHERE molecule_id = 'TR012' AND bond_type = '=')) AS T1 JOIN atom AS T2 ON T1.atom_id = T2.atom_id OR T1.atom_id2 = T2.atom_id WHERE T2.element = 'c';

/*
Prediction Result:
('TR012',)
*/