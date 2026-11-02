-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (372360, 372360, '0998-06-30', 'open_session');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (6, 7, '2019-06-28', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(USER_ID) AS ACTIVE_USERS FROM (SELECT USER_ID, ACTIVITY_DATE FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY 1, 2 HAVING COUNT(ACTIVITY_TYPE) >= 1) AS T GROUP BY 1;

/*
Prediction Result:
*/