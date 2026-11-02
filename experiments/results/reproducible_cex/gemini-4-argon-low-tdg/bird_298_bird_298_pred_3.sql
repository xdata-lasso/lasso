-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests 100% boundary condition where all matching '+' molecule atoms are 'h',
-- while a '-' molecule has only non-'h' atoms.
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m1', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('m2', '-');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a1', 'm1', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a2', 'm1', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a3', 'm2', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a4', 'm2', 'o');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T1.element = 'h' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) AS percentage FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'h';

/*
Prediction Result:
(200.0,)
*/