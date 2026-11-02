-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (29, 31, '2023-01-01', 'end_session'), (31, 29, NULL, 'send_message'), (NULL, 0, '2019-07-26', 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-26', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 GROUP BY ACTIVITY_DATE HAVING COUNT(USER_ID) > 0;

/*
Prediction Result:
('2023-01-01', 1)
*/