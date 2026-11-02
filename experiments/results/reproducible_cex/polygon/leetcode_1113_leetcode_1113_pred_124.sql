-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255), CHECK ("action_date" <= 2019 - 07 - 05));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EXTRA AS REPORT_REASON, COUNT(DISTINCT POST_ID) AS REPORT_COUNT FROM ACTIONS WHERE ACTION = 'report' AND ACTION_DATE = '2019-07-04' GROUP BY EXTRA;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT DISTINCT EXTRA, POST_ID FROM ACTIONS WHERE ACTION_DATE = '2019-07-04' AND ACTION = 'report') SELECT DISTINCT EXTRA AS REPORT_REASON, COUNT(POST_ID) OVER (PARTITION BY EXTRA) AS REPORT_COUNT FROM T;

/*
Prediction Result:
*/