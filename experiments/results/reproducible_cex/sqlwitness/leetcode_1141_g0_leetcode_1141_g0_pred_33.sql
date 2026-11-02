-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 31, '2023-01-01', 'scroll_down'), (30, 30, '2019-07-26', 'scroll_down'), (NULL, 29, '2019-06-29', 'scroll_down'), (0, 1, '2019-06-27', 'scroll_down'), (0, 29, '2023-01-01', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-29', 0)
('2019-07-26', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) > 0;

/*
Prediction Result:
('2019-07-26', 1)
('2023-01-01', 1)
*/