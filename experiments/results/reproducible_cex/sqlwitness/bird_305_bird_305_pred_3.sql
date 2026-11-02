-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', '-', '-'), ('-', NULL, 'default1'), ('default1', NULL, 'default1'), ('unique_3', '-', 'default2'), ('unique_4', '-', NULL), ('unique_5', '-', 'default1'), ('unique_6', NULL, 'default2'), ('unique_7', '-', 'default2'), ('unique_8', '-', NULL), ('unique_9', '-', NULL), ('unique_10', '-', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', NULL, NULL), ('default2', '-', '-'), ('default1', '-', 'default2'), ('unique_3', NULL, 'default1'), ('unique_4', NULL, 'default1'), ('unique_5', NULL, 'default1'), ('unique_6', '-', NULL), ('unique_7', '-', '-'), ('unique_8', '-', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_6', 'default2'), ('unique_8', 'unique_5', 'unique_4'), ('unique_8', 'unique_8', 'unique_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_id, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Gold Result:
('default2', 'default1', 'unique_6')
*/

-- Prediction Query
SELECT T1.bond_type, T2.atom_id, T2.atom_id2 FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.bond_type = '-';

/*
Prediction Result:
('-', 'default1', 'unique_6')
*/