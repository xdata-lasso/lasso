-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'cl');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.element = 'cl' THEN T.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(T.atom_id) FROM (SELECT T1.atom_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '-') AS T;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN a1.element = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*)) AS chlorine_percentage FROM atom AS a1 JOIN connected AS c ON a1.atom_id = c.atom_id JOIN atom AS a2 ON a2.atom_id = c.atom_id2 JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_type = '-';

/*
Prediction Result:
(100.0,)
*/