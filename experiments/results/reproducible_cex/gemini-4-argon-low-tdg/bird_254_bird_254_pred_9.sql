-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A1', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A2', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A3', 'M1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A4', 'M1', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B1', 'M1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B2', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B3', 'M1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B4', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B5', 'M1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B6', 'M1', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A2', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A3', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A1', 'A4', 'B1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A3', 'B2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A2', 'A4', 'B3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A3', 'A4', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST((SELECT COUNT(T1.atom_id) FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id GROUP BY T2.bond_type ORDER BY COUNT(T2.bond_id) DESC, COUNT(T1.atom_id) NULLS LAST LIMIT 1) AS REAL) * 100 / (SELECT COUNT(atom_id) FROM connected);

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN c.bond_id IN (SELECT bond_id FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id WHERE (a1.element, a2.element) = (SELECT a1.element, a2.element FROM connected JOIN atom AS a1 ON connected.atom_id = a1.atom_id JOIN atom AS a2 ON connected.atom_id2 = a2.atom_id GROUP BY a1.element, a2.element ORDER BY COUNT(*) DESC, a1.element NULLS LAST, a2.element NULLS LAST LIMIT 1)) THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(c.bond_id) AS percentage FROM connected AS c;

/*
Prediction Result:
(100.0,)
*/