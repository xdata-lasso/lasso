-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO removals (post_id, remove_date) VALUES (101, NULL);
INSERT INTO actions (user_id, post_id, action_date, action, extra) VALUES (1, NULL, '2023-01-02', 'comment', 'report'), (0, 100, '2023-01-02', 'share', 'SPAM'), (NULL, 101, '2023-01-02', 'reaction', 'racism'), (99, NULL, '2023-01-02', 'share', 'SPAM');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH TOT AS (SELECT ACTION_DATE, CAST(COUNT(DISTINCT (T2.POST_ID)) AS REAL) / COUNT(DISTINCT (T1.POST_ID)) AS REM FROM ACTIONS AS T1 LEFT JOIN REMOVALS AS T2 ON T1.POST_ID = T2.POST_ID WHERE T1.EXTRA = 'SPAM' GROUP BY T1.ACTION_DATE) SELECT ROUND(AVG(REM) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM TOT;

/*
Prediction Result:
(0.0,)
*/