-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (1, 'Jessie Alloway');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (2, 'Alana');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (3, 'Zack');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (4, 'Alana');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (5, NULL);
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (212, 'NY');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (101, 2, 'NY', 5551234, '2023-01-01 10:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (102, 2, 'NY', 5555678, '2023-01-01 10:05:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "contestant_name" FROM "contestants" WHERE ("contestant_name" <> 'Jessie Alloway') ORDER BY contestant_name, contestants.contestant_number NULLS LAST;

/*
Gold Result:
('Alana',)
('Alana',)
('Zack',)
*/

-- Prediction Query
SELECT contestant_name FROM contestants WHERE contestant_name <> 'Jessie Alloway';

/*
Prediction Result:
('Alana',)
('Zack',)
('Alana',)
*/