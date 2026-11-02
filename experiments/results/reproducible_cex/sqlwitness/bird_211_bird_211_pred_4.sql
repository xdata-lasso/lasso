-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('-', '-'), ('default1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', NULL, 'default2'), ('-', NULL, 'default1'), ('default2', 'default1', 'default2'), ('unique_3', 'default1', 'default2'), ('unique_4', NULL, NULL), ('unique_5', NULL, 'default1'), ('unique_6', NULL, '-'), ('unique_7', 'default1', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, 'default2'), ('default2', NULL, 'default2'), ('-', '-', 'default2'), ('unique_3', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', '-', 'unique_4'), ('default1', 'default2', 'default2'), ('-', 'unique_3', NULL), ('default2', 'unique_3', 'unique_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN connected AS T3 ON T1.atom_id = T3.atom_id WHERE T2.label = '-';

/*
Gold Result:
('-',)
*/

-- Prediction Query
SELECT c.atom_id, c.atom_id2 FROM connected AS c JOIN atom AS a1 ON c.atom_id = a1.atom_id JOIN atom AS a2 ON c.atom_id2 = a2.atom_id JOIN molecule AS m ON a1.molecule_id = m.molecule_id WHERE m.label = '-';

/*
Prediction Result:
('-', 'unique_3')
*/