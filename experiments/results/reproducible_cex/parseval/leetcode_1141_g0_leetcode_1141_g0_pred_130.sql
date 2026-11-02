-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -55602865, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -59984348, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -664303813, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1022641847, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1726781632, '2019-07-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 247012447, '2019-07-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1980249628, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -734455130, '2019-06-27', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1744686505, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -1633151678, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, -252690330, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 1115440883, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1644814318, '2019-06-28', 'act_d0588c');

INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1, 1465859724, '2019-06-28', 'act_d0588c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-07-27', 1)
*/

-- Prediction Query
SELECT A.ACTIVITY_DATE AS DAY, COUNT(A.ACTIVITY_DATE) AS ACTIVE_USERS FROM (SELECT DISTINCT USER_ID, ACTIVITY_DATE FROM ACTIVITY) AS A WHERE A.ACTIVITY_DATE < '2019-07-27' AND A.ACTIVITY_DATE > '2019-06-27' GROUP BY ACTIVITY_DATE ORDER BY ACTIVITY_DATE ASC, DAY NULLS LAST, ACTIVE_USERS NULLS LAST;

/*
Prediction Result:
('2019-06-28', 2)
*/