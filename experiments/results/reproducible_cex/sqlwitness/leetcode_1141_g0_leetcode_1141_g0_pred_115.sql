-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (0, 0, NULL, 'send_message'), (NULL, 0, '2019-07-28', 'end_session'), (NULL, NULL, '2019-07-28', 'scroll_down'), (1, NULL, '2019-07-26', 'scroll_down'), (0, 1, '2019-06-27', 'send_message'), (NULL, 0, '2019-06-28', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 0)
('2019-07-26', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING DAY > '2019-06-27' AND DAY <= '2019-07-27' AND ACTIVE_USERS <> 0;

/*
Prediction Result:
('2019-07-26', 1)
*/