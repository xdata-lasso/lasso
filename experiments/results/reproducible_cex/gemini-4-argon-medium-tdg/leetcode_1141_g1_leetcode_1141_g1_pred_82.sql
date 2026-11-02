-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests handling of NULL values in user_id and activity_date, and ensures all activity_types are counted.
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 101, '2019-07-15', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 102, '2019-07-15', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 103, NULL, 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 104, '2019-07-16', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-07-15', 1)
('2019-07-16', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE, USER_ID FROM ACTIVITY WHERE ACTIVITY_DATE <= '2019-07-27' AND ACTIVITY_DATE >= '2019-06-28' GROUP BY ACTIVITY_DATE, USER_ID) AS A GROUP BY DAY;

/*
Prediction Result:
('2019-07-15', 2)
('2019-07-16', 1)
*/