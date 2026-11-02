-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR018', 'site');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('purpose', 'face');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('brother', 'election');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ago', 'dog');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('chair', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('since', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('blue', 'TR018', 'sit');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('require', 'TR018', 'sit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.bond_type FROM (SELECT T1.bond_type, COUNT(T1.molecule_id) FROM bond AS T1 WHERE T1.molecule_id = 'TR018' GROUP BY T1.bond_type ORDER BY COUNT(T1.molecule_id) DESC, T1.bond_type NULLS LAST LIMIT 1) AS T;

/*
Gold Result:
('sit',)
*/

-- Prediction Query
SELECT T1."bond_type", T2."label" FROM "bond" AS T1 INNER JOIN "molecule" AS T2 ON T1."molecule_id" = T2."molecule_id" WHERE T1."molecule_id" = 'TR010' GROUP BY T1."bond_type" ORDER BY COUNT(T1."bond_type") DESC, T1."bond_type" NULLS LAST, T2."label" NULLS LAST LIMIT 1;

/*
Prediction Result:
*/