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
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'si');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'si');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'si');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', NULL, 'si');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm1', 'SI');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm1', 'silicon');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm1', 'ti');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm1', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a7', 'b2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.element = 'si';

/*
Gold Result:
('a1',)
('a2',)
('a3',)
('a4',)
*/

-- Prediction Query
SELECT DISTINCT T1.molecule_id FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.element = 'c';

/*
Prediction Result:
('m1',)
*/