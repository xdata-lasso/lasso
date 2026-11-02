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
WITH TMP3 AS (WITH TMP2 AS (WITH TMP1 AS (SELECT DISTINCT ACTION_DATE, POST_ID FROM ACTIONS WHERE EXTRA = 'SPAM' AND ACTION = 'REPORT') SELECT ACTION_DATE, SUM(1) AS TT, SUM(IIF(R.POST_ID IS NULL, 0, 1)) AS RT FROM TMP1 AS T1 LEFT JOIN REMOVALS AS R ON T1.POST_ID = R.POST_ID GROUP BY ACTION_DATE) SELECT ROUND(CAST(RT * 100 AS REAL) / TT, 2) AS RES FROM TMP2) SELECT ROUND(AVG(RES), 2) AS AVERAGE_DAILY_PERCENT FROM TMP3;

/*
Prediction Result:
(None,)
*/