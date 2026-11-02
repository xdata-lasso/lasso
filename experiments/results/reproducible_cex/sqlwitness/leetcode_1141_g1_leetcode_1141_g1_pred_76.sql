-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (0, 1, '2019-06-27', 'end_session'), (NULL, -1, '2019-07-27', 'send_message'), (1, 1, '2019-07-28', 'open_session'), (NULL, 1, '2019-06-28', 'scroll_down'), (1, 1, '2023-01-01', 'scroll_down'), (-1, 1, '2019-06-26', 'send_message'), (NULL, NULL, '2019-06-26', 'end_session'), (0, NULL, NULL, 'send_message'), (1, 1, '2019-06-28', 'send_message'), (-1, -1, '2019-06-29', 'end_session'), (NULL, NULL, '2019-06-27', 'scroll_down'), (0, NULL, NULL, 'send_message'), (1, 0, '2023-01-01', 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-27', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING ACTIVITY_DATE BETWEEN DATE('2019-06-28') AND DATE('2019-07-27') AND ACTIVE_USERS > 0;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 1)
*/