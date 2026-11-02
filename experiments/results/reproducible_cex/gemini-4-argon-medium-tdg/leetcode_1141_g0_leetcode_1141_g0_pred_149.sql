-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 1, '2019-07-10', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, NULL, '2019-07-10', 'scroll_down');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (NULL, 2, '2019-07-11', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-07-10', 1)
('2019-07-11', 0)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN DATE('2019-07-27', '-29 DAY') AND '2019-07-27' GROUP BY ACTIVITY_DATE HAVING COUNT(DISTINCT USER_ID) > 0;

/*
Prediction Result:
('2019-07-10', 1)
*/