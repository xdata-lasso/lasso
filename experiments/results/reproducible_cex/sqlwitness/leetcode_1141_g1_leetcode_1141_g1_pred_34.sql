-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (1, NULL, '2019-06-28', 'end_session'), (NULL, 0, NULL, 'send_message'), (1, 1, '2019-07-28', 'open_session'), (NULL, NULL, '2019-06-29', 'send_message'), (NULL, 0, NULL, 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 0)
*/

-- Prediction Query
SELECT DAY, SUM(ACTIVE_USERS) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE AS DAY, USER_ID, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE >= '2019-06-28' GROUP BY ACTIVITY_DATE, USER_ID) AS T GROUP BY DAY;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 0)
('2019-07-28', 1)
*/