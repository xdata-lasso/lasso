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
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a2', 'b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(2.5,)
*/

-- Prediction Query
SELECT AVG(CASE WHEN "atom"."element" = 'o' THEN 1 ELSE 0 END) FROM "atom" JOIN "bond" ON "atom"."molecule_id" = "bond"."molecule_id" WHERE "bond"."bond_type" = '-';

/*
Prediction Result:
(0.7142857142857143,)
*/