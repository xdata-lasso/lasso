-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm1', 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm2', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a4', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a5', 'a6', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a6', 'a5', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a7', 'a8', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a8', 'a7', 'b4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id IN (SELECT T3.bond_id FROM connected AS T3 INNER JOIN atom AS T4 ON T3.atom_id = T4.atom_id WHERE T4.element = 'p') AND T1.element = 'n';

/*
Gold Result:
('b1',)
*/

-- Prediction Query
SELECT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element IN ('p', 'n');

/*
Prediction Result:
('b1',)
('b1',)
('b2',)
('b3',)
*/