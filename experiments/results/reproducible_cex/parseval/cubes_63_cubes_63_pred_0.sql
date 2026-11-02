-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: area_code_state --
INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483648, 'CA');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (1, 'vot_06fd43');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (2, 'vot_14659a');

-- Inserting into table: contestants --
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (-2147483648, 'con_6d7ba2');

-- Inserting into table: votes --
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1, -2147483648, 'CA', -55602865, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (2, -2147483648, 'vot_14659a', 1, NULL);

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (-2147483646, -2147483648, 'CA', 1914020640, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (-2147483645, -2147483648, 'CA', 1219478689, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (3, -2147483648, 'vot_06fd43', 1, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (4, -2147483648, 'vot_06fd43', 1, '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created" AS "max_created_" FROM (SELECT "created", "vote_id", MAX("state") AS "state" FROM "votes" GROUP BY "created", "vote_id") WHERE ("state" = 'CA') ORDER BY max_created_;

/*
Gold Result:
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
*/

-- Prediction Query
SELECT MAX(created) FROM votes WHERE state = 'CA';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00',)
*/