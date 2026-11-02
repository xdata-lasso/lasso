-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m6', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm2', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm3', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm3', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm4', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm4', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a12', 'm5', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a13', 'm5', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm3', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm3', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'm3', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b8', 'm4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b9', 'm4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b10', 'm5', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b11', 'm6', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b12', 'm6', '-');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a4', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a5', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a6', 'a7', 'b5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a7', 'a8', 'b6');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a8', 'a9', 'b7');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a10', 'a11', 'b8');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a12', 'a13', 'b10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(6.666666666666667,)
*/

-- Prediction Query
SELECT AVG(single_bond_count) FROM (SELECT COUNT("bond"."bond_id") AS single_bond_count FROM "molecule" INNER JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "molecule"."label" = '+' AND "bond"."bond_type" = '-' GROUP BY "molecule"."molecule_id");

/*
Prediction Result:
(2.0,)
*/