-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (2, NULL, '2023-01-01', 'open_session'), (2, 0, '2019-07-26', 'send_message'), (NULL, 2, '2019-06-28', 'end_session'), (1, 0, '2019-07-26', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 0)
('2019-07-26', 2)
*/

-- Prediction Query
SELECT DISTINCT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) >= 1 AND ACTIVITY_DATE >= DATE('2019-07-27', '-29 day') AND ACTIVITY_DATE <= '2019-07-27';

/*
Prediction Result:
('2019-07-26', 2)
*/