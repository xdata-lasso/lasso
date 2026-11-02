-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=18', 'c23', 'c');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('=20', 'c23', 'c21');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('=22', 'c23', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('c13', 'c23', 'c19');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('=12', 'c23');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('c23', 'c23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element = 'c' THEN T1.atom_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T1.atom_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '=';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN "atom"."element" = 'c' THEN 1 ELSE 0 END) * 1.0 / COUNT("atom"."atom_id") * 100 AS percentage FROM "atom" INNER JOIN "bond" ON "atom"."molecule_id" = "bond"."molecule_id" WHERE "bond"."bond_type" = '=';

/*
Prediction Result:
(50.0,)
*/