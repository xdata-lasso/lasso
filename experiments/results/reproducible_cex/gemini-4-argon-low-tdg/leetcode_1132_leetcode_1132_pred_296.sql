-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1, 101, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (2, 102, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (3, 103, '2023-07-01', 'report', 'spam');
INSERT INTO "Actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (4, 104, '2023-07-02', 'report', 'spam');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (101, '2023-07-01');
INSERT INTO "Removals" ("post_id", "remove_date") VALUES (104, '2023-07-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(66.67,)
*/

-- Prediction Query
WITH SPAM_REPORTS AS (SELECT POST_ID, ACTION_DATE FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM' GROUP BY POST_ID, ACTION_DATE), SPAM_REMOVAL AS (SELECT REP.ACTION_DATE, COUNT(RM.POST_ID) AS REMOVAL_NUM FROM SPAM_REPORTS AS REP LEFT JOIN REMOVALS AS RM ON REP.POST_ID = RM.POST_ID GROUP BY REP.ACTION_DATE), SPAM_REMOVAL_RATE AS (SELECT SR.ACTION_DATE, CAST(SR.REMOVAL_NUM AS REAL) / COUNT(REP.POST_ID) AS TARGET_VALUE FROM SPAM_REPORTS AS REP JOIN SPAM_REMOVAL AS SR ON SR.ACTION_DATE = REP.ACTION_DATE GROUP BY SR.ACTION_DATE) SELECT ROUND(AVG(TARGET_VALUE) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM SPAM_REMOVAL_RATE;

/*
Prediction Result:
(None,)
*/