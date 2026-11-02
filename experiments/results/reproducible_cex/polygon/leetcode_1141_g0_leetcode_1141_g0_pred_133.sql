-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 6, '2019-07-27', 'end_session');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (8, 372389, '2019-07-28', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-27', 0)
*/

-- Prediction Query
WITH COUT AS (SELECT ACTIVITY_DATE, USER_ID, COUNT(DISTINCT (USER_ID)) AS COUNT FROM ACTIVITY GROUP BY ACTIVITY_DATE) SELECT ACTIVITY_DATE AS DAY, COUNT AS ACTIVE_USERS FROM COUT WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 AND '2019-07-27' > ACTIVITY_DATE;

/*
Prediction Result:
*/