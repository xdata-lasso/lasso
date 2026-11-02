-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (31, NULL, '2019-06-29', 'open_session'), (30, 28, NULL, 'open_session'), (29, 29, '2019-07-28', 'scroll_down'), (0, 1, '2023-01-02', 'open_session'), (29, 29, '2019-06-29', 'end_session'), (28, NULL, NULL, 'send_message'), (28, 1, '2019-06-29', 'scroll_down'), (0, 29, '2019-07-28', 'end_session'), (1, 28, '2019-06-28', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 3)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY(ACTIVITY_DATE) - JULIANDAY('2019-07-27')) AS INTEGER) < 29 AND CAST((JULIANDAY(ACTIVITY_DATE) - JULIANDAY('2019-07-27')) AS INTEGER) > -30 GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 3)
('2019-07-28', 2)
*/