-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1, 1, '2020-01-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (2, 2, '2020-01-01', 'REPORT', 'SPAM');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (1, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
WITH B AS (SELECT DISTINCT A.ACTION_DATE, CAST(SUM(IIF(NOT R.POST_ID IS NULL, 1, 0)) AS REAL) / COUNT(A.ACTION_DATE) AS PERC FROM (SELECT DISTINCT ACTION_DATE, POST_ID, ACTION, EXTRA FROM ACTIONS) AS A LEFT JOIN REMOVALS AS R ON R.POST_ID = A.POST_ID AND R.REMOVE_DATE >= A.ACTION_DATE WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' GROUP BY ACTION_DATE) SELECT ROUND(AVG(PERC) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM B;

/*
Prediction Result:
(0.0,)
*/