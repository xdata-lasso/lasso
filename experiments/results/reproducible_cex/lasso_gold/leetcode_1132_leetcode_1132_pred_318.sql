-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1001, 1002, '1970-01-01', 'report', 'spam');
INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1001, NULL, '1970-01-01', 'report', 'spam');
INSERT INTO "removals" ("post_id", "remove_date") VALUES (1002, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT POST_ID, ACTION_DATE FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM') SELECT ROUND(AVG(DAILY_PERCENT), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT CAST(SUM(CASE WHEN NOT R.POST_ID IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(CTE.POST_ID) * 100 AS DAILY_PERCENT FROM CTE LEFT JOIN REMOVALS AS R ON CTE.POST_ID = R.POST_ID AND ACTION_DATE <= REMOVE_DATE GROUP BY ACTION_DATE) AS TMP;

/*
Prediction Result:
(None,)
*/