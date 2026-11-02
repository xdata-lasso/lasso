-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, NULL, '2019-07-15', NULL);
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 501, '2019-07-15', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 502, '2019-07-15', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 503, '2019-07-16', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-07-15', 2)
('2019-07-16', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY WHERE (CAST((JULIANDAY(DATE('2019-07-27')) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) - (CAST((JULIANDAY(DATE(ACTIVITY_DATE)) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) BETWEEN 0 AND 29 GROUP BY ACTIVITY_DATE HAVING ACTIVE_USERS > 0;

/*
Prediction Result:
('2019-07-15', 2)
*/