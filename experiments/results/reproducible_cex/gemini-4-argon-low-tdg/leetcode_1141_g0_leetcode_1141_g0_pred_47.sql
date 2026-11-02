-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 5, '2019-07-20', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 6, '2019-07-21', 'send_message');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 7, '2019-07-22', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 8, '2019-07-23', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-20', 1)
('2019-07-21', 1)
('2019-07-22', 1)
('2019-07-23', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' AND NOT ACTIVITY_TYPE IS NULL GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-07-20', 1)
('2019-07-21', 1)
('2019-07-22', 1)
*/