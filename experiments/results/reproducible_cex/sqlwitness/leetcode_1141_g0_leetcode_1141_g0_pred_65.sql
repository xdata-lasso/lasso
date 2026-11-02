-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (1, 0, '2019-07-27', 'scroll_down'), (0, NULL, '2019-06-28', 'end_session'), (0, 0, '2019-06-29', 'scroll_down'), (NULL, 0, NULL, 'end_session'), (NULL, 1, '2019-06-26', 'end_session'), (1, NULL, '2019-07-28', 'scroll_down'), (NULL, NULL, NULL, 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-27', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE < '2019-07-27' AND ACTIVITY_DATE > '2019-06-27' GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 1)
*/