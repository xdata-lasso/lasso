-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General case: Mix of voted and unvoted contestants, duplicate names, NULL names, NULLs in VOTES, multiple votes per contestant.
-- Expected Gold Query Output: 1 row with value 3
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (213, 'CA');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (4, NULL);
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (5, 'Charlie');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (101, 1, 'NY', 5550101, '2023-01-01 10:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (102, 1, 'CA', 5550102, '2023-01-01 10:05:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (103, 2, 'NY', 5550103, '2023-01-01 10:10:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (104, NULL, 'CA', 5550104, '2023-01-01 10:15:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM (SELECT * FROM contestants AS LHS WHERE NOT EXISTS(SELECT 1 FROM votes AS RHS WHERE (LHS.contestant_number = RHS.contestant_number))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM contestants WHERE NOT contestant_number IN (SELECT contestant_number FROM votes);

/*
Prediction Result:
(0,)
*/