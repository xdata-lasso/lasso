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
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm2', '#');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a2', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a4', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a4', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a4', 'b5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a2', 'b5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(54.54545454545455,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN element1 <> element2 THEN bond_id ELSE NULL END) AS REAL) * 100 / COUNT(bond_id) FROM (SELECT T2.bond_id, T1.element AS element1, T3.element AS element2 FROM atom AS T1 JOIN connected AS T4 ON T1.atom_id = T4.atom_id JOIN atom AS T3 ON T3.atom_id = T4.atom_id2 JOIN bond AS T2 ON T2.bond_id = T4.bond_id) WHERE element1 <> element2;

/*
Prediction Result:
(100.0,)
*/