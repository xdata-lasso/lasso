-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (205, 'AL');
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (415, 'CA');
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (212, 'NY');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (1, 'Alice');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (2, 'Bob');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1, 1, 'CA', 4155550101, '2023-05-10 12:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (2, 2, 'CA', 4155550102, '2023-05-01 08:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (3, 1, 'CA', 4155550103, '2023-05-01 08:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (4, 1, 'AL', 2055550104, '2023-05-02 09:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (5, 2, 'NY', 2125550105, '2023-05-03 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created" AS "max_created_" FROM (SELECT "created", "vote_id", MAX("state") AS "state" FROM "votes" GROUP BY "created", "vote_id") WHERE ("state" = 'CA') ORDER BY max_created_;

/*
Gold Result:
('2023-05-01 08:00:00',)
('2023-05-01 08:00:00',)
('2023-05-10 12:00:00',)
*/

-- Prediction Query
SELECT MAX(created) FROM votes WHERE state = 'CA';

/*
Prediction Result:
('2023-05-10 12:00:00',)
*/