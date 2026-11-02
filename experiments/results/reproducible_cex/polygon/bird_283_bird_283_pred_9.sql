-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ca19', 'ca21', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ca20', 'ca21', 'ca');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('ca14', 'ca21', 'ca21');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('ca20', 'ca20', 'ca14');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca13', 'ca21');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ca21', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label AS flag_carcinogenic FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT "molecule"."label" FROM "atom" INNER JOIN "molecule" ON "atom"."molecule_id" = "molecule"."molecule_id" WHERE "atom"."element" = 'ca';

/*
Prediction Result:
(None,)
*/