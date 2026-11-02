-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm2', 'n');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'n' AND T1.label = '+';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS count FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE atom.element = 'n' AND molecule.label = '+';

/*
Prediction Result:
(5,)
*/