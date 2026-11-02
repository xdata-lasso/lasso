-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (5, 6, '2019-06-28', 'send_message');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (7, 8, '2019-07-28', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COALESCE(COUNT(DISTINCT USER_ID), 0) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 GROUP BY DAY HAVING ACTIVE_USERS > 0;

/*
Prediction Result:
('2019-06-28', 1)
('2019-07-28', 1)
*/