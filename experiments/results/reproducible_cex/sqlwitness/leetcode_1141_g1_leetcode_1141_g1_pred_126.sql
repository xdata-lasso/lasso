-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (0, 1, '2019-06-28', 'send_message'), (30, 30, '2023-01-02', 'open_session'), (29, 30, '2019-07-26', 'open_session'), (NULL, 29, '2019-06-27', 'end_session'), (1, 30, '2019-07-28', 'send_message'), (28, 29, NULL, 'scroll_down'), (-1, 28, '2019-07-27', 'open_session'), (NULL, 0, '2019-06-26', 'open_session'), (29, NULL, NULL, 'open_session');
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
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) <= 29 AND CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) > 0 GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 1)
('2019-07-26', 1)
*/