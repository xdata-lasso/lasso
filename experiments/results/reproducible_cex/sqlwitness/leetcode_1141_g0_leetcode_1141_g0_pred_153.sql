-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 1, '2019-07-26', 'end_session'), (1, NULL, '2019-07-26', 'send_message'), (1, NULL, '2019-06-29', 'send_message'), (NULL, 1, '2019-06-28', 'end_session'), (0, 0, '2023-01-02', 'open_session'), (1, 0, '2019-07-27', 'end_session'), (NULL, 1, '2026-10-01', 'scroll_down'), (NULL, NULL, '2019-06-29', 'scroll_down'), (0, NULL, NULL, 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 0)
('2019-06-29', 1)
('2019-07-26', 1)
('2019-07-27', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT DISTINCT USER_ID, ACTIVITY_DATE FROM ACTIVITY WHERE ACTIVITY_DATE >= DATE('2019-07-27', '-29 DAY') AND ACTIVITY_DATE <= '2019-07-27') AS A GROUP BY ACTIVITY_DATE HAVING COUNT(*) >= '1';

/*
Prediction Result:
*/