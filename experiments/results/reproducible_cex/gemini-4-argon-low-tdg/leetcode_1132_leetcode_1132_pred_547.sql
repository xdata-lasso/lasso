-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1, 101, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (2, 102, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (3, 103, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (4, 104, '2023-07-02', 'report', 'spam');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (101, '2023-07-01');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (104, '2023-07-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
WITH REPORTED AS (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS REPORTED_POSTS FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' GROUP BY ACTION_DATE), REMOVED AS (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS REMOVED_POSTS FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' AND POST_ID IN (SELECT POST_ID FROM REMOVALS) GROUP BY ACTION_DATE), REPORTED_DAYS AS (SELECT COUNT(DISTINCT ACTION_DATE) AS TOTAL_DAYS FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM') SELECT ROUND(AVG(COUNTER), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT (CAST(COALESCE(REMOVED_POSTS * 100, 0) AS REAL) / REPORTED_POSTS) AS COUNTER FROM REPORTED AS R1 LEFT JOIN REMOVED AS R2 ON R1.ACTION_DATE = R2.ACTION_DATE) AS A;

/*
Prediction Result:
(None,)
*/