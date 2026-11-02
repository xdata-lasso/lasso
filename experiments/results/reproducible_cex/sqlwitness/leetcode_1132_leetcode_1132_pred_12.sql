-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO removals (post_id, remove_date) VALUES (1, '2023-01-01'), (2, '2023-01-02');
INSERT INTO actions (user_id, post_id, action_date, action, extra) VALUES (2, 0, '2023-01-01', 'reaction', 'SPAM'), (0, 1, '2023-01-01', 'like', 'spam'), (100, NULL, '2023-01-01', 'like', 'spam'), (100, 2, NULL, 'reaction', 'racism');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT ROUND(AVG(DAILY_AVE) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT ACTION_DATE, CAST(COUNT(CASE WHEN POST_ID IN (SELECT POST_ID FROM REMOVALS) THEN 1 ELSE NULL END) AS REAL) / COUNT(POST_ID) AS DAILY_AVE FROM (SELECT DISTINCT ACTION_DATE, POST_ID, CASE WHEN EXTRA = 'SPAM' THEN EXTRA ELSE NULL END AS EXTRA FROM ACTIONS) AS A WHERE EXTRA = 'SPAM' GROUP BY 1) AS FINAL;

/*
Prediction Result:
(0.0,)
*/