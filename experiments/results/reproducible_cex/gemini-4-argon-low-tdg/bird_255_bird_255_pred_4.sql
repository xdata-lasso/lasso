-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic calculation, fractional division (CAST AS REAL), and DISTINCT vs ALL counting on molecule_id vs bond_id.
-- Total '-' bonds = 3, '+' labeled '-' bonds = 1. Expected result: 33.333333333333336.
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm2', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.label = '+' THEN T1.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T1.bond_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT ROUND(SUM(m.label = '+') * 100.0 / COUNT(b.bond_id), 5) AS percentage FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-';

/*
Prediction Result:
(33.33333,)
*/