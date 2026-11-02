-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 2, '2023-01-01', 'end_session'), (NULL, 1, '2019-06-28', 'scroll_down'), (NULL, NULL, '2023-01-01', 'send_message'), (NULL, 0, NULL, 'open_session'), (1, 0, '2023-01-01', 'end_session'), (2, 2, NULL, 'end_session'), (NULL, 2, '2019-07-26', 'end_session'), (0, 1, '2019-07-26', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 0)
('2019-07-26', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) >= 1;

/*
Prediction Result:
('2019-07-26', 1)
*/