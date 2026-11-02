-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-31', '-34', '-32');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-35', '-37', '-32');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-36', '-37', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-33', '-34', '-');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('-35', '-35', '-33');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-34', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('-37', '-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.element) FROM (SELECT DISTINCT T2.molecule_id, T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '-') AS T;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.element) FROM atom AS T2 INNER JOIN bond AS T1 ON T2.molecule_id = T1.molecule_id WHERE T1.bond_type = '-' GROUP BY T2.molecule_id HAVING COUNT(DISTINCT T1.bond_type) = 1;

/*
Prediction Result:
(1,)
(1,)
*/