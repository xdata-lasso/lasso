-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR018', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR019', 'TR018');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'TR018', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'TR018', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'TR018', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'TR018', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'TR018', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'TR018', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'TR018', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'TR018', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'TR018', '3');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'TR018', '3');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'TR019', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b8', 'TR019', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b9', 'TR019', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b10', 'TR019', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b11', 'TR019', '1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a4', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a1', 'b4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT T1.bond_type, T3.label FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id INNER JOIN molecule AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.bond_type) DESC, T1.bond_type NULLS LAST, T3.label NULLS LAST LIMIT 1;

/*
Prediction Result:
('1', '+')
*/