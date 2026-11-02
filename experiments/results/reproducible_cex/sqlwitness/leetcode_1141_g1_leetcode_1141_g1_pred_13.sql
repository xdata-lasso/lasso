-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, NULL, '2019-06-26', 'scroll_down'), (0, NULL, '2019-07-27', 'send_message'), (NULL, -1, '2019-07-26', 'send_message'), (1, -1, '2019-07-27', 'send_message'), (0, NULL, '2019-06-26', 'open_session'), (NULL, -1, '2023-01-02', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-07-26', 0)
('2019-07-27', 2)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE HAVING ACTIVE_USERS > 0;

/*
Prediction Result:
('2019-07-27', 2)
*/