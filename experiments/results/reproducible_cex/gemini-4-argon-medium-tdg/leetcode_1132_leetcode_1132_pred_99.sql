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
WITH TMP AS (SELECT * FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM') SELECT ROUND(AVG(PERCENT) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT ACTION_DATE, (CAST((SUM(REMOVED_FLAG)) AS REAL) / (SUM(REPORTED_FLAG))) AS PERCENT FROM (SELECT A.*, COALESCE(B.REMOVED_FLAG, 0) AS REMOVED_FLAG FROM (SELECT ACTION_DATE, POST_ID, 1 AS REPORTED_FLAG FROM TMP GROUP BY ACTION_DATE, POST_ID) AS A LEFT JOIN (SELECT *, 1 AS REMOVED_FLAG FROM REMOVALS) AS B ON A.POST_ID = B.POST_ID AND A.ACTION_DATE <= B.REMOVE_DATE) AS T GROUP BY ACTION_DATE) AS TMP;

/*
Prediction Result:
(None,)
*/