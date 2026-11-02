-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1011, 1012, '2019-07-12', 'dog');
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1017, 1018, '2019-07-12', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-12', 2)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(USER_ID) AS ACTIVE_USERS FROM (SELECT USER_ID, ACTIVITY_DATE FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY 1, 2 HAVING COUNT(ACTIVITY_TYPE) >= 1) AS T GROUP BY 1;

/*
Prediction Result:
('2019-07-12', 1)
*/