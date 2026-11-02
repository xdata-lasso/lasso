-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1, 1, '2019-07-04', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (2, 2, '2019-07-04', 'view', 'SPAM');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (1, '2019-07-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
WITH PER AS (SELECT CAST(COUNT(DISTINCT REMOVALS.POST_ID) AS REAL) / COUNT(DISTINCT TEMP.POST_ID) AS PERCENT FROM (SELECT * FROM ACTIONS WHERE EXTRA = 'SPAM') AS TEMP LEFT JOIN REMOVALS ON TEMP.POST_ID = REMOVALS.POST_ID GROUP BY ACTION_DATE) SELECT ROUND(AVG(PERCENT) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM PER;

/*
Prediction Result:
(0.0,)
*/