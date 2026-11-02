-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (1, NULL, '2019-06-28', 'scroll_down'), (NULL, 1, '2019-07-28', 'scroll_down'), (1, 1, NULL, 'open_session'), (NULL, 1, '2019-07-27', 'scroll_down'), (NULL, NULL, '2023-01-01', 'open_session'), (1, 0, '2019-06-28', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
('2019-07-27', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE < '2019-07-27' AND ACTIVITY_DATE > '2019-06-27' GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 1)
*/