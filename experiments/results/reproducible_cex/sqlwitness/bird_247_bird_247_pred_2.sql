-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('pb', 'pb'), ('na', 'na'), ('c', 'default1'), ('default2', NULL), ('s', 'c'), ('p', 'cl');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('h', 'p', 'br'), ('o', 'na', 'br'), ('na', 'na', 'default1'), ('ca', 'default2', NULL), ('cl', 'na', 'na'), ('i', 'pb', 'n'), ('p', 'na', 'n'), ('s', 'default2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('s', 'p', 'cl'), ('c', 'pb', 'p'), ('o', NULL, 'cl'), ('h', 'p', 'sn'), ('sn', 'p', 'cl');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('h', 's', 's'), ('c', 'o', 'cl'), ('c', 'h', 'h'), ('s', 's', 'i'), ('h', 'sn', 's');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T.element FROM atom AS T WHERE NOT T.element IN (SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.element FROM atom AS T1 LEFT JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.atom_id IS NULL AND T1.element IN ('cl', 'c', 'h', 'o', 's', 'n', 'p', 'na', 'br', 'f', 'i', 'sn', 'pb', 'te', 'ca');

/*
Prediction Result:
('cl',)
*/