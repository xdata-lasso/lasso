-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests 1-to-many fanout on '+' vs '-' molecules, fractional division (CAST AS REAL), and COUNT(DISTINCT T1.molecule_id) vs COUNT(*).
-- Note: In the joined result, m1 has 2 matching rows (2 'h' atoms * 1 '#' bond), while m2 and m3 have 1 row each.
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm3', 'h');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm2', '#');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm3', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(DISTINCT a.molecule_id) = 0 THEN 0 ELSE (COUNT(DISTINCT CASE WHEN m.label = '+' THEN m.molecule_id ELSE NULL END) * 100.0 / COUNT(DISTINCT a.molecule_id)) END AS percentage FROM connected AS c JOIN atom AS a ON c.atom_id = a.atom_id JOIN bond AS b ON c.bond_id = b.bond_id JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE a.element = 'h' AND b.bond_type = '#';

/*
Prediction Result:
(0,)
*/