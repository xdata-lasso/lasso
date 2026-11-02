-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting of 'ca' elements per label, WHERE filter (ignoring 'c' and NULL), and ORDER BY DESC vs ASC / missing LIMIT 1.
-- Also tests grouping by T2.label vs T2.molecule_id: '+' has 2 molecules with 2 'ca' each (total 4), '-' has 1 molecule with 3 'ca' (total 3).
-- Also includes a 'c' atom in '-' to catch mutants missing the WHERE clause (which would make '-' tie or beat '+').
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '0');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm3', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm3', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm3', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm4', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
('+',)
*/

-- Prediction Query
SELECT MAX(T2.label) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Prediction Result:
('0',)
*/