-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 1, '2020-01-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (2, 2, '2020-01-01', 'view', 'SPAM');
INSERT INTO Removals (post_id, remove_date) VALUES (1, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(PERCENT) AS REAL) / COUNT(DISTINCT D), 2) AS AVERAGE_DAILY_PERCENT FROM (WITH SPAMS AS (SELECT * FROM ACTIONS AS A WHERE A.EXTRA = 'SPAM') SELECT S.ACTION_DATE AS D, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT S.POST_ID) * 100 AS PERCENT FROM SPAMS AS S LEFT JOIN REMOVALS AS R ON S.POST_ID = R.POST_ID GROUP BY D) AS TEMP;

/*
Prediction Result:
(0.0,)
*/