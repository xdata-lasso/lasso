-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('i', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'i', 'default1'), ('default1', 'default1', 'default1'), ('i', NULL, 'default1'), ('unique_3', 'i', 'default1'), ('unique_4', 'i', 'i');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'i'), ('default2', NULL, 'i'), ('i', NULL, 'default1'), ('unique_3', 'default1', NULL), ('unique_4', NULL, 'default1'), ('unique_5', NULL, 'i'), ('unique_6', 'i', NULL), ('unique_7', NULL, 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default2', 'i', 'unique_4'), ('default1', 'default1', 'i'), ('unique_4', 'unique_5', 'i'), ('unique_6', 'unique_7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.bond_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element = 'i';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.bond_id) FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'i';

/*
Prediction Result:
(2,)
*/