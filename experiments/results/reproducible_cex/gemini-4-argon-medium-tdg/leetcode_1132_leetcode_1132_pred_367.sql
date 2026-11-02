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
WITH SPAM AS (SELECT A.ACTION_DATE, COUNT(DISTINCT A.POST_ID) AS SPAM_POSTS FROM ACTIONS AS A WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' GROUP BY A.ACTION_DATE), REMOVED AS (SELECT A.ACTION_DATE, COALESCE(COUNT(DISTINCT R.POST_ID), 0) AS REMOVED_POSTS FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'REPORT' AND A.EXTRA = 'SPAM' GROUP BY A.ACTION_DATE) SELECT ROUND(AVG(AVERAGE_DAILY_PERCENT), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT S.ACTION_DATE, CAST(REMOVED_POSTS * 100 AS REAL) / SPAM_POSTS AS AVERAGE_DAILY_PERCENT FROM SPAM AS S INNER JOIN REMOVED AS R ON S.ACTION_DATE = R.ACTION_DATE) AS A;

/*
Prediction Result:
(None,)
*/