-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A5', 'M2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A6', 'M3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A7', 'M3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A8', 'M3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A9', 'M3', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M2', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M3', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A1', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A4', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A4', 'A3', 'B4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A6', 'A7', 'B5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.molecule_id FROM (SELECT T2.molecule_id, COUNT(T1.atom_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' GROUP BY T2.molecule_id ORDER BY COUNT(T1.atom_id) DESC, T2.molecule_id NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('M2',)
*/

-- Prediction Query
SELECT molecule.label FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE molecule.label = '+' GROUP BY molecule.molecule_id ORDER BY COUNT(atom.atom_id) DESC, molecule.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('+',)
*/