-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'p');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('b1',)
*/

-- Prediction Query
SELECT T1.bond_id FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN atom AS T3 ON T2.atom_id = T3.atom_id INNER JOIN atom AS T4 ON T2.atom_id2 = T4.atom_id WHERE T3.element = 'p' AND T4.element = 'n';

/*
Prediction Result:
('b1',)
('b1',)
*/