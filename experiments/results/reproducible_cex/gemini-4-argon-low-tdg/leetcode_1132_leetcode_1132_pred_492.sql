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
WITH CTE AS (SELECT ACTION_DATE, COUNT(DISTINCT T2.POST_ID) AS NUM_REMOVED FROM ACTIONS AS T JOIN REMOVALS AS T2 ON T.POST_ID = T2.POST_ID AND (T.ACTION = 'REPORT' AND T.EXTRA = 'SPAM') AND (T.ACTION_DATE <= T2.REMOVE_DATE) GROUP BY ACTION_DATE) SELECT ROUND(CAST(SUM(PERCENTAGE) AS REAL) / COUNT(*), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT T3.ACTION_DATE, ROUND((CAST(COALESCE(CTE.NUM_REMOVED, 0) AS REAL) / TOTAL_CNT) * 100, 2) AS PERCENTAGE FROM (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS TOTAL_CNT FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' GROUP BY ACTION_DATE) AS T3 LEFT JOIN CTE ON T3.ACTION_DATE = CTE.ACTION_DATE) AS T4;

/*
Prediction Result:
(None,)
*/