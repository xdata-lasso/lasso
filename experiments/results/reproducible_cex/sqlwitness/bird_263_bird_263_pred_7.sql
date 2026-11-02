-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('default1', NULL), ('-', 'default1'), ('cl', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('cl', 'cl', NULL), ('default1', 'default1', 'default2'), ('default2', 'default1', 'default2'), ('-', NULL, 'default2'), ('unique_4', 'cl', 'cl'), ('unique_5', '-', '-'), ('unique_6', NULL, 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('cl', 'default1', 'default1'), ('-', '-', NULL), ('default2', 'cl', 'default1'), ('default1', 'default2', 'default1'), ('unique_4', 'default2', '-'), ('unique_5', 'default2', 'default2'), ('unique_6', 'default2', 'cl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'cl' THEN T.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(T.atom_id) FROM (SELECT T1.atom_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '-') AS T;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN atom.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(atom.atom_id) AS percent FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = '-';

/*
Prediction Result:
(None,)
*/