-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "AREA_CODE_STATE" ("area_code", "state") VALUES (1, 'NY');
INSERT INTO "CONTESTANTS" ("contestant_number", "contestant_name") VALUES (1, 'Tabatha Gehling');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (1, 1, 'NY', 123, '2023-01-02 00:00:00');
INSERT INTO "VOTES" ("vote_id", "contestant_number", "state", "phone_number", "created") VALUES (2, 1, 'NY', 123, '2023-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "created", "state", "phone_number" FROM (SELECT "LHS"."contestant_number" AS "contestant_number", "LHS"."contestant_name" AS "contestant_name", "RHS"."vote_id" AS "vote_id", "RHS"."phone_number" AS "phone_number", "RHS"."state" AS "state", "RHS"."created" AS "created" FROM (SELECT * FROM "contestants" WHERE ("contestant_name" = 'Tabatha Gehling')) AS LHS INNER JOIN votes AS RHS ON (LHS.contestant_number = RHS.contestant_number)) ORDER BY created, "created" NULLS LAST, "state" NULLS LAST, "phone_number" NULLS LAST;

/*
Gold Result:
('2023-01-01 00:00:00', 'NY', 123)
('2023-01-02 00:00:00', 'NY', 123)
*/

-- Prediction Query
SELECT T2.created, T2.state, T2.phone_number FROM contestants AS T1 JOIN votes AS T2 ON T1.contestant_number = T2.contestant_number WHERE T1.contestant_name = 'Tabatha Gehling';

/*
Prediction Result:
('2023-01-02 00:00:00', 'NY', 123)
('2023-01-01 00:00:00', 'NY', 123)
*/