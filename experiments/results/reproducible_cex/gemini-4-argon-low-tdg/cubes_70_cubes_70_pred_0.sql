-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Edge case: All contestants have received votes (0 unvoted contestants).
-- Reference query returns 0 rows (since the subquery is empty and COUNT(*) OVER () is not evaluated),
-- killing mutants that use standard aggregate COUNT(*) without OVER() which would return a single row with 0.
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (310, 'CA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (201, 1, 'CA', 5550201, '2023-02-01 12:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (202, 2, 'CA', 5550202, '2023-02-01 12:05:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM (SELECT * FROM contestants AS LHS WHERE NOT EXISTS(SELECT 1 FROM votes AS RHS WHERE (LHS.contestant_number = RHS.contestant_number))) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM contestants WHERE NOT contestant_number IN (SELECT contestant_number FROM votes);

/*
Prediction Result:
(0,)
*/