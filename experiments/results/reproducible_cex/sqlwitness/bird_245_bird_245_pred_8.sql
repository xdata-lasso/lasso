-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('i', 'default2'), ('default2', 'default1'), ('default1', NULL), ('unique_3', 'default1'), ('unique_4', 'i');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'i', 'default1'), ('i', 'unique_3', 'default2'), ('default1', 'unique_4', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('i', 'unique_3', NULL), ('default1', 'default1', 'i'), ('default2', 'i', 'default2'), ('unique_3', 'default1', 'i');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'default2', 'i'), ('i', 'unique_3', NULL), ('unique_3', 'unique_3', 'default1'), ('i', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT COUNT(*) / COUNT(DISTINCT T1.atom_id) AS average_bonds FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T2.element = 'i';

/*
Prediction Result:
(2,)
*/