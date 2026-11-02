-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 1, '2019-07-26', 'send_message'), (31, 31, '2023-01-02', 'scroll_down'), (30, NULL, '2023-01-01', 'scroll_down'), (30, 31, '2019-06-29', 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-29', 1)
('2019-07-26', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-28') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) <= 30 GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-29', 1)
('2019-07-26', 0)
('2023-01-01', 1)
('2023-01-02', 1)
*/