-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm1', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm1', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a4', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a1', 'b5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(57.142857142857146,)
*/

-- Prediction Query
SELECT 100.0 * CAST(COUNT(connected.bond_id) AS REAL) / CAST((SELECT COUNT(*) FROM connected) AS REAL) AS percentage FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id GROUP BY a1.element, a2.element ORDER BY COUNT(*) DESC, percentage NULLS LAST LIMIT 1;

/*
Prediction Result:
(14.285714285714286,)
*/