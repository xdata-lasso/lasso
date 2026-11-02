-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255), CHECK ("action_date" <= 2019 - 07 - 05));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Actions (user_id, post_id, action_date, action, extra) VALUES (1, 1, 2000, 'report', 'spam');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT EXTRA AS REPORT_REASON, COUNT(DISTINCT POST_ID) AS REPORT_COUNT FROM ACTIONS WHERE ACTION = 'report' AND ACTION_DATE = '2019-07-04' GROUP BY EXTRA;

/*
Gold Result:
*/

-- Prediction Query
SELECT EXTRA AS REPORT_REASON, COUNT(DISTINCT (POST_ID)) AS REPORT_COUNT FROM ACTIONS WHERE NOT EXTRA IS NULL AND ACTION = 'report' AND ACTION_DATE = (SELECT MAX(ACTION_DATE) FROM ACTIONS) GROUP BY EXTRA;

/*
Prediction Result:
('spam', 1)
*/