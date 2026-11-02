-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -55602865, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -59984348, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -664303813, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1022641847, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1726781632, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 247012447, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1980249628, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -734455130, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1744686505, NULL, 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, -1633151678, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, -252690330, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 1115440883, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1644814318, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1465859724, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1349201381, '2019-06-28', 'act_d0588c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE, USER_ID FROM ACTIVITY WHERE ACTIVITY_DATE <= '2019-07-27' AND ACTIVITY_DATE >= '2019-06-28' GROUP BY ACTIVITY_DATE, USER_ID) AS A GROUP BY DAY;

/*
Prediction Result:
('2019-06-28', 2)
*/