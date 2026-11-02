-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 10, '2019-07-05', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 11, '2019-07-05', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 12, '2019-07-06', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 13, NULL, 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-05', 1)
('2019-07-06', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY WHERE (CAST((JULIANDAY(DATE('2019-07-27')) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) - (CAST((JULIANDAY(DATE(ACTIVITY_DATE)) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) BETWEEN 0 AND 29 GROUP BY ACTIVITY_DATE HAVING ACTIVE_USERS > 0;

/*
Prediction Result:
('2019-07-05', 1)
*/