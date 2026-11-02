-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actions --
INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-55602865, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-921145356, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1258409369, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1981402255, 5, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-890215420, 2, '2022-04-27', 'act_d78944', 'act_73d7ef');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-106629402, -2147483643, NULL, 'act_d78944', 'act_73d7ef');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1871297066, -2147483642, NULL, 'act_d78944', 'act_73d7ef');

-- Inserting into table: removals --
INSERT INTO "removals" ("post_id", "remove_date") VALUES (1, '2025-06-13');

INSERT INTO "removals" ("post_id", "remove_date") VALUES (2, '2020-06-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
WITH CTE3 AS (SELECT DISTINCT ACTION_DATE FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM'), CTE1 AS (SELECT ACTION_DATE, COUNT(DISTINCT CASE WHEN EXTRA = 'SPAM' THEN POST_ID ELSE NULL END) AS TOTAL_POST FROM ACTIONS WHERE ACTION = 'REPORT' GROUP BY 1), CTE AS (SELECT ACTION_DATE, COUNT(DISTINCT CASE WHEN NOT R.REMOVE_DATE IS NULL AND ACTION = 'REPORT' AND EXTRA = 'SPAM' THEN R.POST_ID ELSE NULL END) AS REMOVED FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID GROUP BY 1) SELECT ROUND(AVG(AVGG) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT CTE.ACTION_DATE, (CAST(REMOVED AS REAL) / TOTAL_POST) AS AVGG FROM CTE JOIN CTE1 ON CTE.ACTION_DATE = CTE1.ACTION_DATE JOIN CTE3 ON CTE3.ACTION_DATE = CTE1.ACTION_DATE) AS A;

/*
Prediction Result:
(None,)
*/