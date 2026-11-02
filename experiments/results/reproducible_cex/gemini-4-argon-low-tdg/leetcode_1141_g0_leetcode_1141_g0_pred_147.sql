-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 10, '2019-06-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 20, '2019-06-28', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 30, '2019-07-15', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 40, '2019-07-27', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (5, 50, '2019-07-28', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-07-15', 1)
('2019-07-27', 1)
*/

-- Prediction Query
WITH NOOF_ACTIVE_USERS AS (SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_TYPE IN ('open_session', 'end_session', 'scroll_down', 'send_message') GROUP BY DAY) SELECT DAY, ACTIVE_USERS FROM NOOF_ACTIVE_USERS WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(DAY)) AS INTEGER) < 30;

/*
Prediction Result:
('2019-06-28', 1)
('2019-07-15', 1)
('2019-07-27', 1)
('2019-07-28', 1)
*/