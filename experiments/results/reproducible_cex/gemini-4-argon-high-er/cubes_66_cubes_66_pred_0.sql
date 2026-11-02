-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (100, 'CA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Tabatha Gehling');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (1, 1, 'CA', 1234567890, '2023-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "area_code" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "LHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "RHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "RHS"."area_code" AS "area_code" FROM "votes" AS "LHS" INNER JOIN "area_code_state" AS "RHS" ON ("LHS"."state" = "RHS"."state")) AS "LHS" INNER JOIN "contestants" AS "RHS" ON ("LHS"."contestant_number" = "RHS"."contestant_number")) AS "LHS" INNER JOIN (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling' AND "contestant_name" <> 'Kelly Clauss')) AS RHS ON (LHS.contestant_number = RHS.contestant_number AND LHS.contestant_name = RHS.contestant_name)) ORDER BY area_code, "area_code" NULLS LAST;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Tabatha Gehling' INTERSECT SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Kelly Clauss';

/*
Prediction Result:
*/