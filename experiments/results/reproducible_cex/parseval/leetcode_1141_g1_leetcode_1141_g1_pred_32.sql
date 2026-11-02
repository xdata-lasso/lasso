-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-55602865, -59984348, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-664303813, -1022641847, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1726781632, 247012447, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1980249628, -734455130, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1744686505, -1633151678, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-252690330, 1115440883, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1644814318, 1465859724, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1349201381, 1019800248, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1910425938, -845863578, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1610064545, 429706943, '2019-07-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (462974032, -1137908826, '2019-07-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-918961358, -1602639011, '2019-07-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-45536098, 1861536320, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (44952191, 1151980946, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1620389964, 546571701, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (947159877, 1990080517, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1408123494, -1964997180, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1149850321, -1833165707, NULL, 'act_d0588c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 9)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY(ACTIVITY_DATE) - JULIANDAY('2019-07-27')) AS INTEGER) > -30 GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 9)
('2019-07-28', 3)
*/