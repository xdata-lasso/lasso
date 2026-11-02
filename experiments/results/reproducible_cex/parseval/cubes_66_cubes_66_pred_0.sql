-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: area_code_state --
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1, 'lhs_78b850');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483647, '_2');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (2, 'lhs_75883f');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483645, 'A');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483644, 'Q');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483643, 'G');

INSERT INTO "area_code_state" ("area_code", "state") VALUES (-2147483642, 'O');

-- Inserting into table: contestants --
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1, 'Tabatha Gehling');

INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (-2147483647, 'Tabatha Gehling');

-- Inserting into table: votes --
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1, 1, 'lhs_78b850', 1, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (-2147483647, 1, 'lhs_75883f', 1, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (2, 1, 'lhs_78b850', 1, '2024-06-15 00:00:00+00:00');

INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (3, 1, 'lhs_78b850', 1, '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "area_code" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "LHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "RHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "RHS"."area_code" AS "area_code" FROM "votes" AS "LHS" INNER JOIN "area_code_state" AS "RHS" ON ("LHS"."state" = "RHS"."state")) AS "LHS" INNER JOIN "contestants" AS "RHS" ON ("LHS"."contestant_number" = "RHS"."contestant_number")) AS "LHS" INNER JOIN (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling' AND "contestant_name" <> 'Kelly Clauss')) AS RHS ON (LHS.contestant_number = RHS.contestant_number AND LHS.contestant_name = RHS.contestant_name)) ORDER BY area_code, "area_code" NULLS LAST;

/*
Gold Result:
(1,)
(1,)
(1,)
(2,)
*/

-- Prediction Query
SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Tabatha Gehling' INTERSECT SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Kelly Clauss';

/*
Prediction Result:
*/