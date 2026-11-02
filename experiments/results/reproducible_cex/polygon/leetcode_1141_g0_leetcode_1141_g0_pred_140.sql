-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (NULL, 5, '2019-07-26', 'end_session');
INSERT INTO "Activity" ("user_id", "session_id", "activity_date", "activity_type") VALUES (372388, 372388, '2019-06-27', 'scroll_down');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-26', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY GROUP BY ACTIVITY_DATE HAVING ACTIVITY_DATE BETWEEN DATE('2019-07-27', '-29 day') AND '2019-07-27';

/*
Prediction Result:
('2019-07-26', 0)
*/