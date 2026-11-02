-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (5, 6, '2019-06-28', 'open_session');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (372360, 372360, '2019-07-28', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
*/

-- Prediction Query
SELECT REFINED_ACTIVITY.DAY, COUNT(*) AS ACTIVE_USERS FROM (SELECT ACTIVITY_DATE AS DAY, COUNT(*) FROM ACTIVITY GROUP BY ACTIVITY_DATE, USER_ID HAVING ACTIVITY_DATE >= '2019-06-28') AS REFINED_ACTIVITY GROUP BY REFINED_ACTIVITY.DAY;

/*
Prediction Result:
('2019-06-28', 1)
('2019-07-28', 1)
*/