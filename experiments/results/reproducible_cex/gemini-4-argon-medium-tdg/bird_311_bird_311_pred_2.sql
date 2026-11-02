-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests boundary conditions where predicates fail:
-- m1 fails because all its atoms have element = 's' (kills missing atom predicate or OR instead of AND).
-- m2 fails because all its bonds have bond_type = '=' (kills missing bond predicate or OR instead of AND).
-- m3 has a qualifying atom but NO bonds (kills LEFT JOIN mutants or queries omitting the bond table).
-- m4 has a qualifying bond but NO atoms (kills RIGHT JOIN mutants or queries omitting the atom table).
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm2', 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm2', '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm3', 'n');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm4', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "molecule"."molecule_id") FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" LEFT JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "atom"."element" <> 's' AND ("bond"."bond_type" IS NULL OR "bond"."bond_type" <> '=');

/*
Prediction Result:
(1,)
*/