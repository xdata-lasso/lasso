-- Schema DDL
CREATE TABLE "Activity" ("user_id" INTEGER, "session_id" INTEGER, "activity_date" DATE, "activity_type" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (2019-06-27 excluded, 2019-06-28 included, 2019-07-27 included, 2019-07-28 excluded) and off-by-one date mutations.
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (1, 101, '2019-06-26', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (2, 102, '2019-06-27', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (3, 103, '2019-06-28', 'open_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (4, 104, '2019-07-27', 'end_session');
INSERT INTO Activity (user_id, session_id, activity_date, activity_type) VALUES (5, 105, '2019-07-28', 'end_session');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users FROM activity WHERE activity_date > '2019-06-27' AND activity_date <= '2019-07-27' GROUP BY activity_date;

/*
Gold Result:
('2019-06-28', 1)
('2019-07-27', 1)
*/

-- Prediction Query
WITH COUT AS (SELECT ACTIVITY_DATE, USER_ID, COUNT(DISTINCT (USER_ID)) AS COUNT FROM ACTIVITY GROUP BY ACTIVITY_DATE) SELECT ACTIVITY_DATE AS DAY, COUNT AS ACTIVE_USERS FROM COUT WHERE CAST((JULIANDAY('2019-07-27') - JULIANDAY(ACTIVITY_DATE)) AS INTEGER) < 30 AND '2019-07-27' > ACTIVITY_DATE;

/*
Prediction Result:
('2019-06-28', 1)
*/