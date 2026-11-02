-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (user_id, session_id, activity_date, activity_type) VALUES (29, 30, '2019-06-27', 'open_session'), (NULL, -1, '2023-01-01', 'end_session'), (30, NULL, '2019-07-28', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTIVITY_DATE AS DAY, COUNT(DISTINCT (USER_ID)) AS ACTIVE_USERS FROM ACTIVITY AS A WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(A.ACTIVITY_DATE)) AS INTEGER) + 1 BETWEEN 0 AND 30 GROUP BY A.ACTIVITY_DATE;

/*
Prediction Result:
('2019-07-28', 1)
*/