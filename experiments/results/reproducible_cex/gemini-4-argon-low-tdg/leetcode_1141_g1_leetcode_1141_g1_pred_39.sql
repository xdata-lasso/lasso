-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 10, '2019-06-26', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 11, '2019-06-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 12, '2019-06-28', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 13, '2019-07-26', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (5, 14, '2019-07-27', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (6, 15, '2019-07-28', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
('2019-07-26', 1)
('2019-07-27', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 GROUP BY 1 HAVING COUNT(DISTINCT USER_ID) >= 1 ORDER BY 1, DAY NULLS LAST, ACTIVE_USERS NULLS LAST;

/*
Prediction Result:
('2019-06-28', 1)
('2019-07-26', 1)
('2019-07-27', 1)
('2019-07-28', 1)
*/