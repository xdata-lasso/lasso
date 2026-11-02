-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1020, 1021, '2019-06-28_z', 'blue');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28_z', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE (CAST((JULIANDAY(DATE('2019-07-27')) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) - (CAST((JULIANDAY(DATE(ACTIVITY_DATE)) - JULIANDAY(DATE('0000-01-01'))) AS INTEGER) + 1) BETWEEN 1 AND 29 GROUP BY ACTIVITY_DATE;

/*
Prediction Result:
*/