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
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '#');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm3', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm3', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a5', 'b5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.bond_type = '#';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(molecule_id) FROM bond WHERE bond_type = '#';

/*
Prediction Result:
(3,)
*/