-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actions (user_id, post_id, action_date, action, extra) VALUES (99, 1, '2023-01-02', 'view', 'spam'), (2, 2, NULL, 'view', 'SPAM'), (99, 99, '2023-01-02', 'report', 'racism');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ROUND(AVG(R_C), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT ACTION_DATE, (CAST(COUNT(DISTINCT T2.POST_ID) AS REAL) / COUNT(DISTINCT T1.POST_ID)) * 100 AS R_C FROM ACTIONS AS T1 LEFT JOIN REMOVALS AS T2 ON T1.POST_ID = T2.POST_ID WHERE EXTRA = 'SPAM' GROUP BY ACTION_DATE) AS TEMP;

/*
Prediction Result:
(0.0,)
*/