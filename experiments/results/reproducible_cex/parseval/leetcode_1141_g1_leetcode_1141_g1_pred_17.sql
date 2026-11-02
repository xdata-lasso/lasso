-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-55602865, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-59984348, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-664303813, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1022641847, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1726781632, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (247012447, 1, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1980249628, NULL, '2019-07-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-734455130, NULL, '2019-07-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1744686505, NULL, '2019-07-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1633151678, NULL, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-252690330, NULL, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1115440883, NULL, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1644814318, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1465859724, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1349201381, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1019800248, NULL, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1910425938, NULL, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-845863578, NULL, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1610064545, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (429706943, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (462974032, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1137908826, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-918961358, NULL, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (-1602639011, NULL, '2019-06-28', 'act_d0588c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 15)
('2019-07-27', 3)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE < '2019-07-27' AND ACTIVITY_DATE > '2019-06-27' GROUP BY ACTIVITY_DATE HAVING COUNT(SESSION_ID) >= 1;

/*
Prediction Result:
('2019-06-28', 15)
*/