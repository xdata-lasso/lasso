-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t1__04b412', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('C', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', '4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Q', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('O', 'e4');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 'hria2ypuzhs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__cbe3f2', 'rwbbp6luhvd');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('B', '5k5swwqcgs');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('D', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', '+');

-- Inserting into table: bond --
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__e699ff', 't1__04b412', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Q', 't1__04b412', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('t1__231345', 't1__04b412', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('O', 't1__04b412', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('_', 't1__04b412', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('/', '@', '-');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('?', 'B', 't1__52ab83');

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('A', 'D', NULL);

INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('@', 'H', '-');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.label = '+' THEN T1.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T1.bond_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-';

/*
Gold Result:
(28.571428571428573,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN "molecule"."label" = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("bond"."bond_id"), 5) FROM "bond" INNER JOIN "molecule" ON "bond"."molecule_id" = "molecule"."molecule_id" WHERE "bond"."bond_type" = '-';

/*
Prediction Result:
(28.57143,)
*/