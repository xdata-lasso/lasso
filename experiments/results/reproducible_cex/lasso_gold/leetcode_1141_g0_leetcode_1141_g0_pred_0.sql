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
SELECT A.ACTIVITY_DATE AS DAY, COUNT(DISTINCT A.USER_ID) AS ACTIVE_USERS FROM ACTIVITY AS A WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 GROUP BY DAY;

/*
Prediction Result:
*/