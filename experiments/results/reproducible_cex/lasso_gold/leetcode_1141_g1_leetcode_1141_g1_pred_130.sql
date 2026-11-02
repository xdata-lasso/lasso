-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (1010, 1011, '2019-07-12', 'election');
INSERT INTO "activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 1013, '2019-07-12', 'dog');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-07-12', 1)
*/

-- Prediction Query
SELECT A.ACTIVITY_DATE AS DAY, COUNT(A.ACTIVITY_DATE) AS ACTIVE_USERS FROM (SELECT DISTINCT USER_ID, ACTIVITY_DATE FROM ACTIVITY) AS A WHERE A.ACTIVITY_DATE < '2019-07-27' AND A.ACTIVITY_DATE > '2019-06-27' GROUP BY ACTIVITY_DATE ORDER BY ACTIVITY_DATE ASC, DAY NULLS LAST, ACTIVE_USERS NULLS LAST;

/*
Prediction Result:
('2019-07-12', 2)
*/