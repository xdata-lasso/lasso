-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 1, '2020-01-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (2, NULL, '2020-01-02', 'report', 'spam');
INSERT INTO Removals (post_id, remove_date) VALUES (1, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT ACTIONS.POST_ID, CAST(COUNT(DISTINCT REMOVALS.POST_ID) AS REAL) / COUNT(DISTINCT ACTIONS.POST_ID) AS RATE FROM ACTIONS LEFT JOIN REMOVALS USING (POST_ID) WHERE EXTRA = 'SPAM' AND ACTION = 'REPORT' GROUP BY ACTION_DATE) SELECT ROUND(AVG(RATE) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM CTE1;

/*
Prediction Result:
(None,)
*/