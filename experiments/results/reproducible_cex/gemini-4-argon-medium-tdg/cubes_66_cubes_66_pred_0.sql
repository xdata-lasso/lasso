-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (206, 'WA');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (415, 'CA');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (312, 'IL');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (617, 'MA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Tabatha Gehling');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Kelly Clauss');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Alana Bregman');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (4, NULL);
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 1, 'CA', 5550101, '2023-01-01 12:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 1, 'WA', 5550102, '2023-01-01 12:05:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 1, 'CA', 5550103, '2023-01-01 12:10:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (104, 1, NULL, 5550104, '2023-01-01 12:15:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (105, 2, 'NY', 5550105, '2023-01-01 12:20:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (106, 3, 'IL', 5550106, '2023-01-01 12:25:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (107, 4, 'WA', 5550107, '2023-01-01 12:30:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (108, NULL, 'CA', 5550108, '2023-01-01 12:35:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "area_code" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "LHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "LHS"."area_code" AS "area_code", "RHS"."contestant_name" AS "contestant_name" FROM (SELECT "LHS"."vote_id" AS "vote_id", "LHS"."phone_number" AS "phone_number", "LHS"."state" AS "state", "LHS"."contestant_number" AS "contestant_number", "LHS"."created" AS "created", "RHS"."area_code" AS "area_code" FROM "votes" AS "LHS" INNER JOIN "area_code_state" AS "RHS" ON ("LHS"."state" = "RHS"."state")) AS "LHS" INNER JOIN "contestants" AS "RHS" ON ("LHS"."contestant_number" = "RHS"."contestant_number")) AS "LHS" INNER JOIN (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling' AND "contestant_name" <> 'Kelly Clauss')) AS RHS ON (LHS.contestant_number = RHS.contestant_number AND LHS.contestant_name = RHS.contestant_name)) ORDER BY area_code, "area_code" NULLS LAST;

/*
Gold Result:
(206,)
(415,)
(415,)
*/

-- Prediction Query
SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Tabatha Gehling' INTERSECT SELECT T3.area_code FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number JOIN area_code_state AS T3 ON T2.state = T3.state WHERE T1.contestant_name = 'Kelly Clauss';

/*
Prediction Result:
*/