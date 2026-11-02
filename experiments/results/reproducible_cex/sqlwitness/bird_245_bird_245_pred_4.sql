-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('default2', 'default1'), ('i', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('i', 'i', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default1', NULL), ('default1', 'unique_4', 'default2'), ('i', NULL, 'i'), ('unique_3', 'default1', 'default1'), ('unique_4', NULL, 'i');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('i', 'unique_4', 'i'), ('unique_4', 'default2', 'i'), ('unique_3', 'unique_3', NULL), ('unique_4', 'unique_4', 'i');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.bond_id) AS REAL) / COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 'i';

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT AVG(bond_count) FROM (SELECT COUNT(b.bond_id) AS bond_count FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.element = 'i' GROUP BY a.atom_id);

/*
Prediction Result:
(1.5,)
*/