-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('option', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('science', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('table', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('decide', 'option', 'sense');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('offer', 'science', 'kind');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('list', 'science', 'perform');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('rate', 'option', '-');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('discussion', 'science', NULL);
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('fall', 'science', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(1.5,)
*/

-- Prediction Query
SELECT AVG(single_bond_count) FROM (SELECT COUNT("bond"."bond_id") AS single_bond_count FROM "molecule" INNER JOIN "bond" ON "molecule"."molecule_id" = "bond"."molecule_id" WHERE "molecule"."label" = '+' AND "bond"."bond_type" = '-' GROUP BY "molecule"."molecule_id");

/*
Prediction Result:
(1.0,)
*/