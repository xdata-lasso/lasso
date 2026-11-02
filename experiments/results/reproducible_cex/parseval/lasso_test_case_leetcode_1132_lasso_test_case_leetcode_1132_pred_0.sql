-- Schema DDL
CREATE TABLE "ACTIONS" ("USER_ID" INTEGER, "POST_ID" INTEGER, "ACTION_DATE" DATE, "ACTION" TEXT, "EXTRA" TEXT);

CREATE TABLE "REMOVALS" ("POST_ID" INTEGER PRIMARY KEY, "REMOVE_DATE" DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actions --
INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-55602865, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-59984348, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-664303813, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1981402255, 2, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-890215420, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1610062532, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-734455130, 2, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1744686505, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1633151678, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-252690330, 2, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1115440883, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1644814318, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1465859724, 2, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1349201381, 3, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1019800248, 4, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1910425938, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-845863578, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1610064545, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (429706943, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (462974032, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1137908826, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-918961358, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-1602639011, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (-45536098, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1861536320, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (44952191, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1151980946, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1620389964, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (546571701, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (947159877, 1, '2024-06-15', 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1990080517, 1408123494, NULL, '4', 'ecigce376n');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (1313172851, -761141909, NULL, '52zbuo4nrq', 'rofqyp5s5b');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (2107872094, 1, NULL, 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (882961052, 1, NULL, 'report', 'spam');

INSERT INTO "actions" ("user_id", "post_id", "action_date", "action", "extra") VALUES (743312762, 1, NULL, 'report', 'spam');

-- Inserting into table: removals --
INSERT INTO "removals" ("post_id", "remove_date") VALUES (1, '2022-12-08');

INSERT INTO "removals" ("post_id", "remove_date") VALUES (5, '2025-04-30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND(CAST(SUM(DAILY_AVG) AS REAL) / COUNT(*) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT A.ACTION_DATE, CAST(COUNT(DISTINCT R.POST_ID) AS REAL) / COUNT(DISTINCT A.POST_ID) AS DAILY_AVG FROM ACTIONS AS A LEFT JOIN REMOVALS AS R ON A.POST_ID = R.POST_ID WHERE A.ACTION = 'report' AND A.EXTRA = 'spam' GROUP BY ACTION_DATE) AS TEMP;

/*
Gold Result:
(62.5,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT POST_ID, ACTION_DATE, CASE WHEN POST_ID IN (SELECT POST_ID FROM REMOVALS) THEN 1 ELSE 0 END AS REMOVAL_FLAG FROM ACTIONS WHERE ACTION = 'REPORT' AND EXTRA = 'SPAM') SELECT ROUND(AVG(PERCENT) * 100, 2) AS AVERAGE_DAILY_PERCENT FROM (SELECT ACTION_DATE, CAST(SUM(REMOVAL_FLAG) AS REAL) / COUNT(POST_ID) AS PERCENT FROM CTE GROUP BY ACTION_DATE) AS CTE1;

/*
Prediction Result:
(None,)
*/