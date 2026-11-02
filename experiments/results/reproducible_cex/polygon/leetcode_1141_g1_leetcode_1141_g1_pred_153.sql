-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (7, 8, '2019-06-28', 'send_message');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 9, '2019-06-28', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT DISTINCT USER_ID, ACTIVITY_DATE FROM ACTIVITY WHERE ACTIVITY_DATE >= DATE('2019-07-27', '-29 DAY') AND ACTIVITY_DATE <= '2019-07-27') AS A GROUP BY ACTIVITY_DATE HAVING COUNT(*) >= '1';

/*
Prediction Result:
*/