-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('-', '-'), ('default1', 'default1'), ('unique_3', '-'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('-', 'default2', 'default1'), ('default2', '-', 'default2'), ('default1', 'unique_3', '-'), ('unique_3', 'unique_3', '-'), ('unique_4', 'unique_4', '-'), ('unique_5', NULL, NULL), ('unique_6', '-', 'default1'), ('unique_7', 'unique_4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-' ORDER BY T2.molecule_id LIMIT 3;

/*
Gold Result:
('unique_3',)
*/

-- Prediction Query
SELECT molecule.molecule_id FROM molecule INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE bond.bond_type = '-' AND molecule.label = '-' ORDER BY molecule.molecule_id ASC, bond.bond_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('unique_3',)
('unique_3',)
*/