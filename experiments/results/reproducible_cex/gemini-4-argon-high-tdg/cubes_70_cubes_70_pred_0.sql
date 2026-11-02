-- Schema DDL
CREATE TABLE "AREA_CODE_STATE" ("area_code" INTEGER PRIMARY KEY, "state" TEXT(2) UNIQUE);

CREATE TABLE "CONTESTANTS" ("contestant_number" INTEGER PRIMARY KEY, "contestant_name" TEXT(50));

CREATE TABLE "VOTES" ("vote_id" INTEGER PRIMARY KEY, "contestant_number" INTEGER, "state" TEXT(2), "phone_number" INTEGER, "created" TIMESTAMP, FOREIGN KEY ("contestant_number") REFERENCES "CONTESTANTS" ("contestant_number"), FOREIGN KEY ("state") REFERENCES "AREA_CODE_STATE" ("state"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO AREA_CODE_STATE (area_code, state) VALUES (212, 'NY');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (1, 'Alice');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (2, 'Bob');
INSERT INTO CONTESTANTS (contestant_number, contestant_name) VALUES (3, 'Charlie');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (1, 1, 'NY', 2125550100, '2023-02-01 12:00:00');
INSERT INTO VOTES (vote_id, contestant_number, state, phone_number, created) VALUES (2, NULL, 'NY', 2125550199, '2023-02-01 12:01:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM (SELECT * FROM contestants AS LHS WHERE NOT EXISTS(SELECT 1 FROM votes AS RHS WHERE (LHS.contestant_number = RHS.contestant_number))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM contestants WHERE NOT contestant_number IN (SELECT contestant_number FROM votes);

/*
Prediction Result:
(0,)
*/