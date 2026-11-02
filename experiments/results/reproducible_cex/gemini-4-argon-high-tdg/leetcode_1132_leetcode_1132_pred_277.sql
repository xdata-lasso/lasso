-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 1, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 2, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 3, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 4, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 5, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 6, '2019-07-01', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (2, 7, '2019-07-02', 'report', 'spam');
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (3, 8, '2019-07-02', 'report', 'spam');
INSERT INTO Removals (post_id, remove_date) VALUES (1, '2019-07-05');
INSERT INTO Removals (post_id, remove_date) VALUES (7, '2019-07-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(33.33,)
*/

-- Prediction Query
WITH MAIN1 AS (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS NUM1 FROM ACTIONS WHERE EXTRA = 'SPAM' AND ACTION = 'REPORT' GROUP BY ACTION_DATE), MAIN2 AS (SELECT ACTION_DATE, COUNT(DISTINCT R.POST_ID) AS NUM2 FROM ACTIONS AS A JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE EXTRA = 'SPAM' AND ACTION = 'REPORT' GROUP BY ACTION_DATE) SELECT ROUND(AVG(DAILY_PERC), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT COALESCE((CAST(MAIN2.NUM2 AS REAL) / MAIN1.NUM1) * 100.0, 0) AS DAILY_PERC FROM MAIN1 LEFT JOIN MAIN2 ON MAIN1.ACTION_DATE = MAIN2.ACTION_DATE) AS MAIN3;

/*
Prediction Result:
(None,)
*/