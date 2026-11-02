-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (2, 1, '2023-01-02', 'send_message'), (0, NULL, '2019-06-29', 'scroll_down'), (NULL, NULL, '2019-07-26', 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-29', 1)
('2019-07-26', 0)
*/

-- Prediction Query
SELECT DISTINCT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) >= 1 AND ACTIVITY_DATE >= DATE('2019-07-27', '-29 day') AND ACTIVITY_DATE <= '2019-07-27';

/*
Prediction Result:
('2019-06-29', 1)
*/