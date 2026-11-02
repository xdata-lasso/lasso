-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (29, 0, '2019-06-29', 'end_session'), (29, 31, '2019-07-28', 'scroll_down'), (1, 1, '2019-06-28', 'send_message'), (NULL, NULL, '2019-07-26', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-26', 0)
*/

-- Prediction Query
WITH NOOF_ACTIVE_USERS AS (SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_TYPE IN ('open_session', 'end_session', 'scroll_down', 'send_message') GROUP BY DAY) SELECT DAY, ACTIVE_USERS FROM NOOF_ACTIVE_USERS WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(DAY)) AS INTEGER) < 30;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-26', 0)
('2019-07-28', 1)
*/