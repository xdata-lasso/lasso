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
WITH T1 AS (SELECT POST_ID, ACTION_DATE FROM ACTIONS WHERE EXTRA = 'SPAM'), T2 AS (SELECT DISTINCT T1.POST_ID AS ID, T1.ACTION_DATE, R.POST_ID AS RID FROM T1 LEFT JOIN REMOVALS AS R ON T1.POST_ID = R.POST_ID), T3 AS (SELECT CAST(COUNT(T2.RID) AS REAL) / COUNT(T2.ID) AS PERCENTAGE FROM T2 GROUP BY T2.ACTION_DATE) SELECT ROUND(AVG(T3.PERCENTAGE) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM T3;

/*
Prediction Result:
(None,)
*/