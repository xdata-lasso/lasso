-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1012, 'Ryan Munoz');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1013, 'Gina Moore');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "contestant_name" FROM "contestants" WHERE ("contestant_name" <> 'Jessie Alloway') ORDER BY contestant_name, contestants.contestant_number NULLS LAST;

/*
Gold Result:
('Gina Moore',)
('Ryan Munoz',)
*/

-- Prediction Query
SELECT contestant_name FROM contestants WHERE contestant_name <> 'Jessie Alloway';

/*
Prediction Result:
('Ryan Munoz',)
('Gina Moore',)
*/