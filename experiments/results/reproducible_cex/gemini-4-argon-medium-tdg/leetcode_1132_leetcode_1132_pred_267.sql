-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 101, '2023-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (2, 102, '2023-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (3, 103, '2023-07-01', 'report', 'racism');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (4, 104, '2023-07-01', 'view', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (5, 105, '2023-07-02', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (6, 106, '2023-07-02', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (7, 107, '2023-07-02', 'report', 'spam');
INSERT INTO Removals (post_id, remove_date) VALUES (101, '2023-07-02');
INSERT INTO Removals (post_id, remove_date) VALUES (103, '2023-07-02');
INSERT INTO Removals (post_id, remove_date) VALUES (105, '2023-07-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(41.67,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS TOTAL_DAILY_SPAM FROM ACTIONS WHERE EXTRA = 'SPAM' AND ACTION = 'REPORT' GROUP BY ACTION_DATE), CTE2 AS (SELECT ACTION_DATE, COUNT(DISTINCT A.POST_ID) AS TOTAL_REMOVAL FROM ACTIONS AS A LEFT JOIN REMOVALS AS B ON A.POST_ID = B.POST_ID WHERE A.EXTRA = 'SPAM' AND A.ACTION = 'REPORT' AND B.REMOVE_DATE > A.ACTION_DATE GROUP BY ACTION_DATE) SELECT ROUND(AVG(DAILY_AVG) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT (CAST(COALESCE(B.TOTAL_REMOVAL, 0) AS REAL) / A.TOTAL_DAILY_SPAM) AS DAILY_AVG FROM CTE1 AS A LEFT JOIN CTE2 AS B ON A.ACTION_DATE = B.ACTION_DATE) AS C;

/*
Prediction Result:
(None,)
*/