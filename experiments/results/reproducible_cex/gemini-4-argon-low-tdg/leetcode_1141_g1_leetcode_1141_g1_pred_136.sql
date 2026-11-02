-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 201, '2019-07-20', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (10, 202, '2019-07-20', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 203, '2019-07-21', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (20, 204, NULL, 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-07-20', 1)
('2019-07-21', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN (DATE('2019-07-27', '-29 day')) AND '2019-07-27' GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) >= 1;

/*
Prediction Result:
('2019-07-20', 1)
*/