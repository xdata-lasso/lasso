-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST((SELECT COUNT(*) FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id WHERE a.element || '-' || a2.element = (SELECT a.element || '-' || a2.element FROM connected AS c INNER JOIN atom AS a ON c.atom_id = a.atom_id INNER JOIN atom AS a2 ON c.atom_id2 = a2.atom_id GROUP BY a.element, a2.element ORDER BY COUNT(*) DESC, a.element || '-' || a2.element NULLS LAST LIMIT 1)) AS REAL) * 100 / (SELECT COUNT(*) FROM connected);

/*
Prediction Result:
(33.333333333333336,)
*/