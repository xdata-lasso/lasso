-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO removals (post_id, remove_date) VALUES (3, '2023-01-02');
INSERT INTO actions (user_id, post_id, action_date, action, extra) VALUES (99, 0, NULL, 'reaction', 'spam'), (3, 3, '2023-01-02', 'like', 'SPAM'), (1, 101, NULL, 'like', 'spam'), (100, 100, '2023-01-01', 'view', 'SPAM');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) * 100 AS PER FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.EXTRA = 'SPAM' GROUP BY A.ACTION_DATE) SELECT ROUND(CAST(SUM(PER) AS REAL) / COUNT(DISTINCT ACTION_DATE), 2) AS AVERAGE_DAILY_PERCENT FROM TEMP;

/*
Prediction Result:
(50.0,)
*/