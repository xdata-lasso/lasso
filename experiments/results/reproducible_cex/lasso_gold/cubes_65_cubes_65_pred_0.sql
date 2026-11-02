-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1078, 'Vermont');
INSERT INTO "area_code_state" ("area_code", "state") VALUES (1082, 'Wisconsin');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1079, 'Tabatha Gehling');
INSERT INTO "contestants" ("contestant_number", "contestant_name") VALUES (1083, 'Tabatha Gehling');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1080, 1079, 'Vermont', 1081, '1988-08-20');
INSERT INTO "votes" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1084, 1083, 'Wisconsin', 1082, '1988-08-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created", "state", "phone_number" FROM (SELECT "LHS"."contestant_number" AS "contestant_number", "LHS"."contestant_name" AS "contestant_name", "RHS"."vote_id" AS "vote_id", "RHS"."phone_number" AS "phone_number", "RHS"."state" AS "state", "RHS"."created" AS "created" FROM (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling')) AS LHS INNER JOIN votes AS RHS ON (LHS.contestant_number = RHS.contestant_number)) ORDER BY created, "created" NULLS LAST, "state" NULLS LAST, "phone_number" NULLS LAST;

/*
Gold Result:
('1988-08-19', 'Wisconsin', 1082)
('1988-08-20', 'Vermont', 1081)
*/

-- Prediction Query
SELECT T2.created, T2.state, T2.phone_number FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number WHERE T1.contestant_name = 'Tabatha Gehling';

/*
Prediction Result:
('1988-08-20', 'Vermont', 1081)
('1988-08-19', 'Wisconsin', 1082)
*/