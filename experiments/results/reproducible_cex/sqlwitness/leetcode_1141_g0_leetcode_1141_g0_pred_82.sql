-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 1, '2019-07-27', 'send_message'), (1, NULL, '2023-01-02', 'open_session'), (0, 0, '2019-07-28', 'end_session'), (0, NULL, NULL, 'end_session'), (0, 1, '2019-06-27', 'open_session'), (0, 1, '2019-07-26', 'end_session'), (NULL, 0, '2019-06-27', 'send_message');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-26', 1)
('2019-07-27', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE, USER_ID FROM ACTIVITY WHERE ACTIVITY_DATE <= '2019-07-27' AND ACTIVITY_DATE >= '2019-06-28' GROUP BY ACTIVITY_DATE, USER_ID) AS A GROUP BY DAY;

/*
Prediction Result:
('2019-07-26', 1)
('2019-07-27', 1)
*/