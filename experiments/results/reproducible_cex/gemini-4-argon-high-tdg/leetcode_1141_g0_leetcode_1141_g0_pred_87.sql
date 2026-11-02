-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 1, '2019-06-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 2, '2019-06-28', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 3, '2019-06-29', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 4, '2019-07-26', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (5, 5, '2019-07-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (6, 6, '2019-07-28', 'open_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE ACTIVITY_DATE BETWEEN '2019-06-28' AND '2019-07-27' GROUP BY ACTIVITY_DATE;

/*
Gold Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-26', 1)
('2019-07-27', 1)
*/

-- Prediction Query
SELECT ACTIVITY_DATE AS DAY, COUNT(DISTINCT USER_ID) AS ACTIVE_USERS FROM ACTIVITY WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 AND ACTIVITY_DATE < '2019-07-27' GROUP BY DAY;

/*
Prediction Result:
('2019-06-28', 1)
('2019-06-29', 1)
('2019-07-26', 1)
*/