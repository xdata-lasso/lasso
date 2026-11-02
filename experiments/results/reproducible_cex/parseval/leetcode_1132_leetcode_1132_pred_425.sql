-- Schema DDL
CREATE TABLE "Actions" ("user_id" INTEGER, "post_id" INTEGER UNIQUE, "action_date" DATE, "action" TEXT(255), "extra" TEXT(255));

CREATE TABLE "Removals" ("post_id" INTEGER PRIMARY KEY, "remove_date" DATE, FOREIGN KEY ("post_id") REFERENCES "Actions" ("post_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actions --
INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-55602865, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-921145356, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1258409369, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1981402255, 5, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-890215420, 2, '2022-04-27', 'act_d78944', 'act_73d7ef');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-106629402, -2147483643, NULL, 'act_d78944', 'act_73d7ef');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1871297066, -2147483642, NULL, 'act_d78944', 'act_73d7ef');

-- Inserting into table: removals --
INSERT INTO "removals" ("post_id", "remove_date") VALUES (1, '2025-06-13');

INSERT INTO "removals" ("post_id", "remove_date") VALUES (2, '2020-06-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
WITH TOT_SPAM AS (SELECT ACTION_DATE, COUNT(DISTINCT POST_ID) AS TOT FROM ACTIONS WHERE EXTRA = 'SPAM' OR EXTRA = 'REVIEW' GROUP BY ACTION_DATE), RM_ AS (SELECT ACTION_DATE, COUNT(DISTINCT RM.POST_ID) AS RM_CNT FROM ACTIONS JOIN REMOVALS AS RM ON ACTIONS.POST_ID = RM.POST_ID WHERE EXTRA = 'SPAM' OR EXTRA = 'REVIEW' GROUP BY ACTION_DATE) SELECT ROUND(AVG(CAST(COALESCE(RM_CNT, 0) AS REAL) / TOT) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM TOT_SPAM LEFT JOIN RM_ ON TOT_SPAM.ACTION_DATE = RM_.ACTION_DATE;

/*
Prediction Result:
(None,)
*/