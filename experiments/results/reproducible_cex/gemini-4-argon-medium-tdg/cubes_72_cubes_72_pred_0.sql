-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests boundary conditions around the literal 'Jessie Alloway' to catch <, <=, >, >=, and LIKE mutants.
-- Tests case sensitivity and NULL handling in the WHERE clause (NULL <> 'Jessie Alloway' is UNKNOWN).
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (10, 'Jessie Alloway');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (11, 'jessie alloway');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (12, 'Jessie Allowax');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (13, 'Jessie Allowaz');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (14, 'Jessie Alloway Jr.');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (15, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "contestant_name" FROM "contestants" WHERE ("contestant_name" <> 'Jessie Alloway') ORDER BY contestant_name, contestants.contestant_number NULLS LAST;

/*
Gold Result:
('Jessie Allowax',)
('Jessie Alloway Jr.',)
('Jessie Allowaz',)
('jessie alloway',)
*/

-- Prediction Query
SELECT contestant_name FROM contestants WHERE contestant_name <> 'Jessie Alloway';

/*
Prediction Result:
('jessie alloway',)
('Jessie Allowax',)
('Jessie Allowaz',)
('Jessie Alloway Jr.',)
*/