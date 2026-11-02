-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 101, '2019-06-26', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 102, '2019-06-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 103, '2019-06-28', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 104, '2019-07-26', 'send_message');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (5, 105, '2019-07-27', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (6, 106, '2019-07-28', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (7, 107, '2019-08-15', 'open_session');
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
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT DISTINCT USER_ID, ACTIVITY_DATE FROM ACTIVITY WHERE ACTIVITY_DATE >= DATE('2019-07-27', '-29 DAY') AND ACTIVITY_DATE <= '2019-07-27') AS A GROUP BY ACTIVITY_DATE HAVING COUNT(*) >= '1';

/*
Prediction Result:
*/