-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+34', 'cl35', 'cl');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('cl11', '+12', '+20');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+14', 'cl35', 'cl35');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('cl13', '+12', 'cl35');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+34', 'cl11', '+14');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('cl11', '+34', 'cl13');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+12', 'cl19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('cl35', '+');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T2.label = '+' AND T1.element = 'cl' THEN T2.molecule_id ELSE NULL END) * 100 / COUNT(T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id;

/*
Gold Result:
(50,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "molecule"."label" = '+' AND "atom"."element" = 'cl' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT "molecule"."molecule_id") AS percentage FROM "molecule" INNER JOIN "atom" ON "molecule"."molecule_id" = "atom"."molecule_id" WHERE "molecule"."label" = '+';

/*
Prediction Result:
(100.0,)
*/