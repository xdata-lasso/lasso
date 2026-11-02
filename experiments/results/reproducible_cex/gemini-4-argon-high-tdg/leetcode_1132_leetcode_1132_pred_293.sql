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
WITH SPAM_COUNT AS (SELECT DISTINCT USER_ID, POST_ID, ACTION_DATE FROM ACTIONS WHERE EXTRA = 'SPAM'), REMOVED_POSTS AS (SELECT DISTINCT A.USER_ID, R.POST_ID, A.ACTION_DATE FROM REMOVALS AS R JOIN ACTIONS AS A ON A.POST_ID = R.POST_ID WHERE A.EXTRA = 'SPAM') SELECT ROUND(100 * AVG(AVG_PCT), 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT S.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT S.POST_ID) AS AVG_PCT FROM SPAM_COUNT AS S LEFT JOIN REMOVED_POSTS AS R ON R.POST_ID = S.POST_ID AND R.USER_ID = S.USER_ID GROUP BY 1) AS RESULT_TABLE;

/*
Prediction Result:
(None,)
*/